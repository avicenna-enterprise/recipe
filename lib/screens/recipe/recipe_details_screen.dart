import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../models/recipe_model.dart';
import '../../viewmodels/recipe_detail_viewmodel.dart';
import '../../viewmodels/saved_viewmodel.dart';
import '../../viewmodels/home_viewmodel.dart';
import '../../viewmodels/notification_viewmodel.dart';
import '../../utils/app_colors.dart';
import 'reviews_screen.dart';
import 'widgets/recipe_hero.dart';
import 'widgets/author_info.dart';
import 'widgets/recipe_tabs.dart';
import 'widgets/ingredient_tile.dart';
import 'widgets/step_tile.dart';
import 'widgets/recipe_options_menu.dart';

class RecipeDetailsScreen extends StatelessWidget {
  final RecipeModel recipe;

  const RecipeDetailsScreen({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RecipeDetailViewModel(recipe: recipe),
      child: const _RecipeDetailsBody(),
    );
  }
}

class _RecipeDetailsBody extends StatelessWidget {
  const _RecipeDetailsBody();

  Future<void> _launchURL(String? url) async {
    if (url == null || url.isEmpty) return;
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<RecipeDetailViewModel>();
    final recipe = vm.recipe;

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          // ── Hero Section (Image + Nav) ───────────────────────────────────
          SliverToBoxAdapter(
            child: RecipeHero(
              recipe: recipe,
              onMoreTap: () => showRecipeOptionsMenu(context, recipe),
            ),
          ),

          // ── Content Info (Title, Author, Tabs) ───────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title + reviews
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          recipe.name.replaceAll('\n', ' '),
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textDark,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '(${recipe.reviewCount ~/ 1000}k Reviews)',
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppColors.textGrey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Author Info Section (Extracted Widget)
                  AuthorInfo(recipe: recipe),
                  const SizedBox(height: 12),

                  // ── Watch Video Button ───────────────────────────────────
                  if (recipe.videoUrl != null)
                    GestureDetector(
                      onTap: () => _launchURL(recipe.videoUrl),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.red.withOpacity(0.3)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.play_circle_fill,
                                color: Colors.red, size: 20),
                            const SizedBox(width: 8),
                            const Text(
                              'Watch Video',
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  const SizedBox(height: 20),

                  // Tabs (Ingredient / Procedure) (Extracted Widget)
                  const RecipeTabs(),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),

          // ── Ingredients / Procedure List ─────────────────────────────
          if (vm.showIngredients)
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final ing = vm.ingredients[index];
                    return IngredientTile(ingredient: ing);
                  },
                  childCount: vm.ingredients.length,
                ),
              ),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return StepTile(step: index + 1, text: vm.steps[index]);
                  },
                  childCount: vm.steps.length,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _errorImage() {
    return Container(
      height: 260,
      color: const Color(0xFF2D6A4F),
      child: const Icon(Icons.restaurant, color: Colors.white54, size: 60),
    );
  }
  Widget _authorError() {
    return Container(
      width: 42,
      height: 42,
      color: AppColors.cardBg,
      child: const Icon(Icons.person, color: AppColors.textGrey),
    );
  }
}

// ── Ingredient Tile ──────────────────────────────────────────────────────
class _IngredientTile extends StatelessWidget {
  final IngredientModel ingredient;

  const _IngredientTile({required this.ingredient});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          // Emoji icon
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                ingredient.emoji,
                style: const TextStyle(fontSize: 26),
              ),
            ),
          ),
          const SizedBox(width: 14),
          // Name
          Expanded(
            child: Text(
              ingredient.name,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: AppColors.textDark,
              ),
            ),
          ),
          // Quantity
          Text(
            ingredient.quantity,
            style: const TextStyle(
              fontSize: 13,
              color: AppColors.textGrey,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Step Tile ────────────────────────────────────────────────────────────
class _StepTile extends StatelessWidget {
  final int step;
  final String text;

  const _StepTile({required this.step, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: const BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '$step',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.textDark,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
