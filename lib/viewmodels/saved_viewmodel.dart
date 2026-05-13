import 'package:flutter/material.dart';
import '../models/recipe_model.dart';

class SavedViewModel extends ChangeNotifier {
  final List<RecipeModel> _savedRecipes = [];

  // Callback to notify HomeViewModel when save state changes
  VoidCallback? onSaveStateChanged;

  List<RecipeModel> get savedRecipes => _savedRecipes;

  void addRecipe(RecipeModel recipe) {
    if (!_savedRecipes.any((r) => r.id == recipe.id)) {
      recipe.isSaved = true;
      _savedRecipes.add(recipe);
      notifyListeners();
      onSaveStateChanged?.call();
    }
  }

  void removeRecipe(String id) {
    final index = _savedRecipes.indexWhere((r) => r.id == id);
    if (index != -1) {
      _savedRecipes[index].isSaved = false;
      _savedRecipes.removeAt(index);
      notifyListeners();
      onSaveStateChanged?.call();
    }
  }

  bool isSaved(String id) => _savedRecipes.any((r) => r.id == id);
}
