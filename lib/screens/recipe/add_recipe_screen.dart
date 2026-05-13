import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../models/recipe_model.dart';
import '../../models/ingredient_model.dart';
import '../../viewmodels/home_viewmodel.dart';
import '../../utils/app_colors.dart';

class AddRecipeScreen extends StatefulWidget {
  final RecipeModel? recipe;
  const AddRecipeScreen({super.key, this.recipe});

  @override
  State<AddRecipeScreen> createState() => _AddRecipeScreenState();
}

class _AddRecipeScreenState extends State<AddRecipeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _timeController = TextEditingController();
  final _ingredientsController = TextEditingController();
  final _proceduresController = TextEditingController();
  String _selectedCategory = 'Indian';
  File? _image;
  bool _isSaving = false;

  final List<String> _categories = [
    'Indian', 'Italian', 'Asian', 'Chinese',
  ];

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _image = File(picked.path);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.recipe != null) {
      _nameController.text = widget.recipe!.name;
      _timeController.text = widget.recipe!.time.replaceAll(' mins', '');
      _selectedCategory = widget.recipe!.category;
      if (!widget.recipe!.image.startsWith('assets/')) {
        _image = File(widget.recipe!.image);
      }
      
      // Load ingredients
      if (widget.recipe!.ingredients != null) {
        _ingredientsController.text = widget.recipe!.ingredients!
            .map((i) => i.name)
            .join('\n');
      }
      
      // Load procedures
      if (widget.recipe!.procedures != null) {
        _proceduresController.text = widget.recipe!.procedures!.join('\n');
      }
    }
  }

  void _saveRecipe() async {
    if (!_formKey.currentState!.validate()) return;
    if (_image == null && widget.recipe == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select an image')),
      );
      return;
    }

    setState(() => _isSaving = true);

    // Simulate small delay
    await Future.delayed(const Duration(seconds: 1));

    final homeVm = context.read<HomeViewModel>();

    // Parse ingredients
    final ingredientsText = _ingredientsController.text.trim();
    List<IngredientModel>? ingredients;
    if (ingredientsText.isNotEmpty) {
      ingredients = ingredientsText.split('\n').where((s) => s.isNotEmpty).map((line) {
        final name = line.trim();
        return IngredientModel(
          name: name,
          quantity: '',
          emoji: RecipeIngredients.getEmoji(name),
        );
      }).toList();
    } else {
      // If empty, try to suggest based on name
      final suggestions = RecipeIngredients.getSuggestions(_nameController.text);
      if (suggestions.isNotEmpty) {
        ingredients = suggestions;
      }
    }

    // Parse procedures
    final proceduresText = _proceduresController.text.trim();
    List<String>? procedures;
    if (proceduresText.isNotEmpty) {
      procedures = proceduresText.split('\n').where((s) => s.isNotEmpty).toList();
    }

    if (widget.recipe == null) {
      // Create new
      final newRecipe = RecipeModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: _nameController.text,
        image: _image!.path, // Using path since it's local
        rating: 0.0,
        time: '${_timeController.text} mins',
        author: homeVm.user.name,
        authorImage: _image!.path, // Using the same image as author image
        category: _selectedCategory,
        isSaved: false,
        ingredients: ingredients,
        procedures: procedures,
      );
      homeVm.addRecipe(newRecipe);
    } else {
      // Update existing
      final updatedRecipe = RecipeModel(
        id: widget.recipe!.id,
        name: _nameController.text,
        image: _image != null ? _image!.path : widget.recipe!.image,
        rating: widget.recipe!.rating,
        time: '${_timeController.text} mins',
        author: widget.recipe!.author,
        authorImage: _image != null ? _image!.path : widget.recipe!.authorImage,
        category: _selectedCategory,
        isSaved: widget.recipe!.isSaved,
        ingredients: ingredients,
        procedures: procedures,
      );
      homeVm.updateRecipe(updatedRecipe);
    }

    setState(() => _isSaving = false);
    Navigator.pop(context);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(widget.recipe == null
              ? 'Recipe added successfully!'
              : 'Recipe updated successfully!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: AppColors.textDark),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Add New Recipe',
          style: TextStyle(
              color: AppColors.textDark,
              fontWeight: FontWeight.bold,
              fontSize: 18),
        ),
        actions: [
          TextButton(
            onPressed: _isSaving ? null : _saveRecipe,
            child: _isSaving
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppColors.primary,
                    ),
                  )
                : const Text(
                    'Save',
                    style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image Picker
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFFEEEEEE)),
                  ),
                  child: _image != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.file(_image!, fit: BoxFit.cover),
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.add_a_photo_outlined,
                                size: 40, color: AppColors.textGrey),
                            SizedBox(height: 8),
                            Text('Add Cover Photo',
                                style: TextStyle(color: AppColors.textGrey)),
                          ],
                        ),
                ),
              ),
              const SizedBox(height: 32),

              // Name Field
              const Text('Recipe Name',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: 'Enter recipe name',
                  filled: true,
                  fillColor: const Color(0xFFF8F8F8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 14),
                ),
                validator: (v) =>
                    v == null || v.isEmpty ? 'Name is required' : null,
              ),
              const SizedBox(height: 24),

              Row(
                children: [
                  // Time Field
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Cook Time (mins)',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _timeController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: 'e.g. 30',
                            filled: true,
                            fillColor: const Color(0xFFF8F8F8),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 14),
                          ),
                          validator: (v) => v == null || v.isEmpty
                              ? 'Required'
                              : null,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Category Dropdown
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Category',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF8F8F8),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: _selectedCategory,
                              isExpanded: true,
                              items: _categories
                                  .map((c) => DropdownMenuItem(
                                        value: c,
                                        child: Text(c),
                                      ))
                                  .toList(),
                              onChanged: (v) {
                                if (v != null) setState(() => _selectedCategory = v);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),

              // Description / Ingredients Placeholder
              // Ingredients Field
              const Text('Ingredients (One per line)',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              TextFormField(
                controller: _ingredientsController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'e.g. 500g Chicken\n2 cups Rice',
                  filled: true,
                  fillColor: const Color(0xFFF8F8F8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Procedures Field
              const Text('Procedures (One per line)',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              TextFormField(
                controller: _proceduresController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'e.g. Boil water\nAdd chicken',
                  filled: true,
                  fillColor: const Color(0xFFF8F8F8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
