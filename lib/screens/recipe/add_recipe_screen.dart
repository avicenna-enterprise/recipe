import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../models/recipe_model.dart';
import '../../models/ingredient_model.dart';
import '../../viewmodels/home_viewmodel.dart';
import '../../utils/app_colors.dart';
import '../profile/add_video_screen.dart';

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
  final List<TextEditingController> _procedureControllers = [];
  final List<_IngredientRow> _ingredientRows = [];
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
        for (var ing in widget.recipe!.ingredients!) {
          _ingredientRows.add(_IngredientRow(
            name: ing.name,
            weight: ing.quantity,
            emoji: ing.emoji,
            image: ing.image != null ? File(ing.image!) : null,
          ));
        }
      } else {
        _addIngredientRow();
      }
      
      // Load procedures
      if (widget.recipe!.procedures != null) {
        for (var p in widget.recipe!.procedures!) {
          _procedureControllers.add(TextEditingController(text: p));
        }
      } else {
        _addProcedureRow();
      }
    } else {
      _addIngredientRow();
      _addProcedureRow();
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _timeController.dispose();
    for (var controller in _procedureControllers) {
      controller.dispose();
    }
    for (var row in _ingredientRows) {
      row.dispose();
    }
    super.dispose();
  }

  void _addProcedureRow() {
    setState(() {
      _procedureControllers.add(TextEditingController());
    });
  }

  void _removeProcedureRow(int index) {
    if (_procedureControllers.length > 1) {
      setState(() {
        _procedureControllers[index].dispose();
        _procedureControllers.removeAt(index);
      });
    }
  }

  void _addIngredientRow() {
    setState(() {
      _ingredientRows.add(_IngredientRow(name: '', weight: '', emoji: '🍳'));
    });
  }

  Future<void> _showIconPicker(int index) async {
    final row = _ingredientRows[index];
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        final commonEmojis = [
          '🍗', '🥩', '🍚', '🧅', '🍅', '🧄', '🥚', '🥛', '🧀', '🧈',
          '🌶️', '🧂', '🍯', '🍋', '🍄', '🥦', '🍝', '🍲', '🥕', '🥒',
          '🥔', '🍖', '🍞', '🐟', '🍎', '🌿', '🥘', '🥣', '🍦', '🍰',
          '🥑', '🌽', '🥬', '🍤', '🥞', '🥓', '🍔', '🍕', '🌭', '🌮',
          '🌯', '🥗', '🍜', '🍛', '🍣', '🥟', '🍪', '🍩', '🍫', '🥤',
        ];
        
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Ingredient Icon',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 20),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Pick from Gallery'),
                onTap: () async {
                  Navigator.pop(context);
                  final picker = ImagePicker();
                  final picked = await picker.pickImage(source: ImageSource.gallery);
                  if (picked != null) {
                    setState(() {
                      _ingredientRows[index].image = File(picked.path);
                    });
                  }
                },
              ),
              const Divider(),
              const SizedBox(height: 10),
              const Text('Or choose an emoji:',
                  style: TextStyle(fontSize: 12, color: AppColors.textGrey)),
              const SizedBox(height: 10),
              SizedBox(
                height: 250,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                  ),
                  itemCount: commonEmojis.length,
                  itemBuilder: (context, i) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          row.emoji = commonEmojis[i];
                          row.image = null; // Clear image if emoji is picked
                          row.isManualEmoji = true; // Mark as manual
                        });
                        Navigator.pop(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8F8F8),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        alignment: Alignment.center,
                        child: Text(commonEmojis[i], style: const TextStyle(fontSize: 32)),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _removeIngredientRow(int index) {
    if (_ingredientRows.length > 1) {
      setState(() {
        _ingredientRows[index].dispose();
        _ingredientRows.removeAt(index);
      });
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

    final homeVm = context.read<HomeViewModel>();

    setState(() => _isSaving = true);

    // Simulate small delay
    await Future.delayed(const Duration(seconds: 1));
    if (!mounted) return;

    // Parse ingredients from rows
    List<IngredientModel> ingredients = [];
    for (var row in _ingredientRows) {
      final name = row.nameController.text.trim();
      if (name.isNotEmpty) {
          ingredients.add(IngredientModel(
            name: name,
            quantity: row.weightController.text.trim(),
            emoji: row.emoji,
            image: row.image?.path,
          ));
        }
      }

    if (ingredients.isEmpty) {
      // If empty, try to suggest based on name
      final suggestions = RecipeIngredients.getSuggestions(_nameController.text);
      if (suggestions.isNotEmpty) {
        ingredients = suggestions;
      }
    }

    // Parse procedures from controllers
    List<String> procedures = [];
    for (var controller in _procedureControllers) {
      final p = controller.text.trim();
      if (p.isNotEmpty) {
        procedures.add(p);
      }
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
    if (!mounted) return;
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
              const SizedBox(height: 24),

              // Description / Ingredients Placeholder
              // Ingredients Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Ingredients',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  GestureDetector(
                    onTap: _addIngredientRow,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.add,
                          color: AppColors.primary, size: 20),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _ingredientRows.length,
                separatorBuilder: (context, index) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final row = _ingredientRows[index];
                  return Row(
                    key: ValueKey(row.id),
                    children: [
                      // Emoji / Icon / Custom Image
                      GestureDetector(
                        onTap: () => _showIconPicker(index),
                        child: Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF8F8F8),
                            borderRadius: BorderRadius.circular(12),
                            border: row.image != null ? Border.all(color: AppColors.primary.withValues(alpha: 0.3)) : null,
                          ),
                          alignment: Alignment.center,
                          child: row.image != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.file(row.image!,
                                      width: 44, height: 44, fit: BoxFit.cover),
                                )
                              : Text(row.emoji,
                                  style: const TextStyle(fontSize: 20)),
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Name
                      Expanded(
                        flex: 3,
                        child: TextFormField(
                          controller: row.nameController,
                          onChanged: (v) {
                            // Auto emoji update only if not manually set
                            if (!row.isManualEmoji && row.image == null) {
                              final newEmoji = RecipeIngredients.getEmoji(v);
                              if (newEmoji != row.emoji) {
                                setState(() => row.emoji = newEmoji);
                              }
                            }
                          },
                          decoration: InputDecoration(
                            hintText: 'Item name',
                            filled: true,
                            fillColor: const Color(0xFFF8F8F8),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 10),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Weight / Quantity
                      Expanded(
                        flex: 2,
                        child: TextFormField(
                          controller: row.weightController,
                          decoration: InputDecoration(
                            hintText: 'Weight',
                            filled: true,
                            fillColor: const Color(0xFFF8F8F8),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 10),
                          ),
                        ),
                      ),
                      if (_ingredientRows.length > 1)
                        IconButton(
                          icon: const Icon(Icons.remove_circle_outline,
                              color: Colors.red, size: 20),
                          onPressed: () => _removeIngredientRow(index),
                        ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 16),

              // Procedures Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Procedures',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  GestureDetector(
                    onTap: _addProcedureRow,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.add,
                          color: AppColors.primary, size: 20),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _procedureControllers.length,
                separatorBuilder: (context, index) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  return Row(
                    key: ValueKey('step_$index'),
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: const BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          '${index + 1}',
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextFormField(
                          controller: _procedureControllers[index],
                          maxLines: null,
                          decoration: InputDecoration(
                            hintText: 'Step ${index + 1}',
                            filled: true,
                            fillColor: const Color(0xFFF8F8F8),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 10),
                          ),
                        ),
                      ),
                      if (_procedureControllers.length > 1)
                        IconButton(
                          icon: const Icon(Icons.remove_circle_outline,
                              color: Colors.red, size: 20),
                          onPressed: () => _removeProcedureRow(index),
                        ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 32),

              // Add Video Button
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.primary.withValues(alpha: 0.1)),
                ),
                child: Column(
                  children: [
                    const Icon(Icons.video_call_outlined, color: AppColors.primary, size: 32),
                    const SizedBox(height: 8),
                    const Text(
                      'Have a video for this recipe?',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Share it with the community!',
                      style: TextStyle(fontSize: 12, color: AppColors.textGrey),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const AddVideoScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        elevation: 0,
                      ),
                      child: const Text('Add Video Now'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}

class _IngredientRow {
  final String id;
  final TextEditingController nameController;
  final TextEditingController weightController;
  String emoji;
  File? image;
  bool isManualEmoji = false;

  _IngredientRow({
    required String name,
    required String weight,
    required this.emoji,
    this.image,
    this.isManualEmoji = false,
  })  : id = DateTime.now().microsecondsSinceEpoch.toString() + name,
        nameController = TextEditingController(text: name),
        weightController = TextEditingController(text: weight);

  void dispose() {
    nameController.dispose();
    weightController.dispose();
  }
}
