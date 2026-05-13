import 'package:flutter/material.dart';
import '../models/recipe_model.dart';
import 'notification_viewmodel.dart';

class SavedViewModel extends ChangeNotifier {
  final List<RecipeModel> _savedRecipes = [];
  NotificationViewModel? _notificationViewModel;

  VoidCallback? onSaveStateChanged;

  List<RecipeModel> get savedRecipes => _savedRecipes;

  void setNotificationViewModel(NotificationViewModel vm) {
    _notificationViewModel = vm;
  }

  void addRecipe(RecipeModel recipe) {
    if (!_savedRecipes.any((r) => r.id == recipe.id)) {
      recipe.isSaved = true;
      _savedRecipes.add(recipe);
      // Trigger notification
      _notificationViewModel?.onRecipeSaved(recipe.name);
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
