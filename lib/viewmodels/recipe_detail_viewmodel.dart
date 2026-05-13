import 'package:flutter/material.dart';
import '../models/recipe_model.dart';
import '../models/ingredient_model.dart';

class RecipeDetailViewModel extends ChangeNotifier {
  final RecipeModel recipe;
  bool _showIngredients = true;
  bool _isFollowing = false;

  RecipeDetailViewModel({required this.recipe});

  bool get showIngredients => _showIngredients;
  bool get isFollowing => _isFollowing;

  List<IngredientModel> get ingredients =>
      RecipeIngredients.getFor(recipe.id);

  // Procedure steps
  List<String> get steps => [
    'Prepare all ingredients and wash them thoroughly.',
    'Heat oil in a pan over medium heat.',
    'Add onions and sauté until golden brown.',
    'Add garlic and ginger, cook for 2 minutes.',
    'Add main ingredients and cook according to recipe time.',
    'Season with spices and adjust to taste.',
    'Serve hot and garnish as desired.',
  ];

  void switchToIngredients() {
    _showIngredients = true;
    notifyListeners();
  }

  void switchToProcedure() {
    _showIngredients = false;
    notifyListeners();
  }

  void toggleFollow() {
    _isFollowing = !_isFollowing;
    notifyListeners();
  }
}
