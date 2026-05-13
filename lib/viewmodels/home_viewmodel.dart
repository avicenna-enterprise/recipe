import 'package:flutter/material.dart';
import '../models/recipe_model.dart';
import '../models/user_model.dart';
import 'saved_viewmodel.dart';

class HomeViewModel extends ChangeNotifier {

  SavedViewModel? _savedViewModel;
  String _searchQuery = '';

  void setSavedViewModel(SavedViewModel vm) {
    _savedViewModel = vm;
    // When saved state changes, notify home to rebuild
    _savedViewModel!.onSaveStateChanged = () {
      notifyListeners();
    };
  }

  UserModel _user = UserModel(
    id: '1',
    name: 'Ayesha',
    email: 'ayesha@email.com',
  );

  int _selectedCategory = 0;

  final List<String> categories = [
    'All', 'Indian', 'Italian', 'Asian', 'Chinese',
  ];

  // ── featured recipes ──────────────────────────────────────────────────────
  final List<RecipeModel> _featured = [
    RecipeModel(
      id: '1',
      name: 'Chicken Biryani',
      image: 'assets/images/biryani.jpeg',
      rating: 4.7,
      time: '45 mins',
      author: 'Chef Ayesha',
      authorImage: 'assets/images/biryani.jpeg',
      category: 'Indian',
      isSaved: false,
    ),
    RecipeModel(
      id: '2',
      name: 'Hotpot Special',
      image: 'assets/images/hotpot.jpeg',
      rating: 4.4,
      time: '35 mins',
      author: 'Chef Li',
      authorImage: 'assets/images/hotpot.jpeg',
      category: 'Chinese',
      isSaved: false,
    ),
    RecipeModel(
      id: '5',
      name: 'Grilled Chicken',
      image: 'assets/images/chicken.jpeg',
      rating: 4.3,
      time: '25 mins',
      author: 'Chef Daniel',
      authorImage: 'assets/images/chicken.jpeg',
      category: 'Asian',
      isSaved: false,
    ),
    RecipeModel(
      id: '6',
      name: 'Italian Food',
      image: 'assets/images/italian_food.jpeg',
      rating: 4.6,
      time: '30 mins',
      author: 'Chef Marco',
      authorImage: 'assets/images/italian_food.jpeg',
      category: 'Italian',
      isSaved: false,
    ),
    RecipeModel(
      id: '9',
      name: 'Crunchy Nut Coleslaw',
      image: 'assets/images/crunchy_nut_coleslaw.jpeg',
      rating: 3.5,
      time: '10 mins',
      author: 'Chef Sara',
      authorImage: 'assets/images/crunchy_nut_coleslaw.jpeg',
      category: 'Asian',
      isSaved: false,
    ),
    RecipeModel(
      id: '10',
      name: 'Classic Greek Salad',
      image: 'assets/images/classic_greek_salad.jpeg',
      rating: 4.5,
      time: '15 mins',
      author: 'Chef Ali',
      authorImage: 'assets/images/classic_greek_salad.jpeg',
      category: 'Italian',
      isSaved: false,
    ),
  ];

  // ── new recipes ───────────────────────────────────────────────────────────
  final List<RecipeModel> _newRecipes = [
    RecipeModel(
      id: '3',
      name: 'Polina Special',
      image: 'assets/images/polina_Tankilevitch.jpeg',
      rating: 4.5,
      time: '20 mins',
      author: 'Chef Sofia',
      authorImage: 'assets/images/polina_Tankilevitch.jpeg',
      category: 'Italian',
      isSaved: false,
    ),
    RecipeModel(
      id: '4',
      name: 'Chicken Biryani (Quick)',
      image: 'assets/images/biryani.jpeg',
      rating: 4.6,
      time: '35 mins',
      author: 'Chef Ayesha',
      authorImage: 'assets/images/biryani.jpeg',
      category: 'Indian',
      isSaved: false,
    ),
    RecipeModel(
      id: '7',
      name: 'Hotpot Street Style',
      image: 'assets/images/hotpot.jpeg',
      rating: 4.2,
      time: '30 mins',
      author: 'Chef Li',
      authorImage: 'assets/images/hotpot.jpeg',
      category: 'Chinese',
      isSaved: false,
    ),
    RecipeModel(
      id: '8',
      name: 'Italian Creamy',
      image: 'assets/images/italian_food.jpeg',
      rating: 4.4,
      time: '28 mins',
      author: 'Chef Marco',
      authorImage: 'assets/images/italian_food.jpeg',
      category: 'Italian',
      isSaved: false,
    ),
    RecipeModel(
      id: '11',
      name: 'Spice Roasted Chicken',
      image: 'assets/images/spice_roasted_chicken.jpeg',
      rating: 4.0,
      time: '40 mins',
      author: 'Mark Kelvin',
      authorImage: 'assets/images/spice_roasted_chicken.jpeg',
      category: 'Asian',
      isSaved: false,
    ),
    RecipeModel(
      id: '12',
      name: 'Steak with Tomato',
      image: 'assets/images/steak_with_tomatto.jpeg',
      rating: 4.0,
      time: '35 mins',
      author: 'Chef John',
      authorImage: 'assets/images/steak_with_tomatto.jpeg',
      category: 'Italian',
      isSaved: false,
    ),
    RecipeModel(
      id: '13',
      name: 'Traditional Spare Ribs Baked',
      image: 'assets/images/Traditional spare.jpeg',
      rating: 4.0,
      time: '60 mins',
      author: 'Chef John',
      authorImage: 'assets/images/Traditional spare.jpeg',
      category: 'Asian',
      isSaved: false,
    ),
    RecipeModel(
      id: '14',
      name: 'Lamb Chops with Fruity Couscous',
      image: 'assets/images/Lamb_chops.jpeg',
      rating: 4.0,
      time: '45 mins',
      author: 'Spicy Nelly',
      authorImage: 'assets/images/Lamb_chops.jpeg',
      category: 'Italian',
      isSaved: false,
    ),
    RecipeModel(
      id: '15',
      name: 'Chinese Style Egg Fried Rice with Sliced',
      image: 'assets/images/Chinese_style_Egg_fried_rice.jpeg',
      rating: 4.0,
      time: '25 mins',
      author: 'Laura Wilson',
      authorImage: 'assets/images/Chinese_style_Egg_fried_rice.jpeg',
      category: 'Chinese',
      isSaved: false,
    ),
  ];

  // ── getters ───────────────────────────────────────────────────────────────
  UserModel get user => _user;
  int get selectedCategory => _selectedCategory;
  String get searchQuery => _searchQuery;
  String get selectedCategoryName => categories[_selectedCategory];
  List<RecipeModel> get featured => _applyFilters(_featured);
  List<RecipeModel> get newRecipes => _applyFilters(_newRecipes);

  List<RecipeModel> get allRecipes => [..._featured, ..._newRecipes];

  List<RecipeModel> get searchResults {
    final q = _searchQuery.trim().toLowerCase();
    if (q.isEmpty) return const [];
    return _applyFilters(allRecipes)
        .where((r) => r.name.toLowerCase().contains(q))
        .toList();
  }

  // ── actions ───────────────────────────────────────────────────────────────
  void selectCategory(int index) {
    _selectedCategory = index;
    notifyListeners();
  }

  void updateSearch(String value) {
    _searchQuery = value;
    notifyListeners();
  }

  void updateSearchQuery(String value) {
    _searchQuery = value;
    notifyListeners();
  }

  List<RecipeModel> _applyFilters(List<RecipeModel> list) {
    final selected = selectedCategoryName;
    if (selected == 'All') return list;
    return list.where((r) => r.category == selected).toList();
  }

  void toggleSave(String recipeId) {
    RecipeModel? recipe;

    final fIdx = _featured.indexWhere((r) => r.id == recipeId);
    if (fIdx != -1) {
      final newSaved = !(_savedViewModel?.isSaved(recipeId) ?? _featured[fIdx].isSaved);
      _featured[fIdx] = _featured[fIdx].copyWith(isSaved: newSaved);
      recipe = _featured[fIdx];
    }

    final nIdx = _newRecipes.indexWhere((r) => r.id == recipeId);
    if (nIdx != -1) {
      final newSaved = !(_savedViewModel?.isSaved(recipeId) ?? _newRecipes[nIdx].isSaved);
      _newRecipes[nIdx] = _newRecipes[nIdx].copyWith(isSaved: newSaved);
      recipe = _newRecipes[nIdx];
    }

    if (recipe != null && _savedViewModel != null) {
      if (_savedViewModel!.isSaved(recipeId)) {
        _savedViewModel!.removeRecipe(recipeId);
      } else {
        _savedViewModel!.addRecipe(recipe);
      }
    }

    notifyListeners();
  }

  void setUser(UserModel user) {
    _user = user;
    notifyListeners();
  }
}
