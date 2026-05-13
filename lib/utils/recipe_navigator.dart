import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/recipe_model.dart';
import '../screens/recipe/recipe_details_screen.dart';
import '../viewmodels/recipe_detail_viewmodel.dart';

void openRecipeDetail(BuildContext context, RecipeModel recipe) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (_) {
        return ChangeNotifierProvider(
          create: (_) => RecipeDetailViewModel(recipe: recipe),
          child: RecipeDetailsScreen(recipe: recipe),
        );
      },
    ),
  );
}
