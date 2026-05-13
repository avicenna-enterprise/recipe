import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/recipe_model.dart';
import '../../models/ingredient_model.dart';
import '../../viewmodels/recipe_detail_viewmodel.dart';
import '../../viewmodels/saved_viewmodel.dart';
import '../../viewmodels/home_viewmodel.dart';
import '../../viewmodels/notification_viewmodel.dart';
import '../../utils/app_colors.dart';
import 'reviews_screen.dart';

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

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<RecipeDetailViewModel>();
    final recipe = vm.recipe;

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          // ── Hero Image ──────────────────────────────────────────────
          SliverToBoxAdapter(
            child: Stack(
              children: [
                // Image
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(24),
                    bottomRight: Radius.circular(24),
                  ),
                  child: recipe.image.startsWith('assets/')
                      ? Image.asset(
                          recipe.image,
                          height: 260,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => _errorImage(),
                        )
                      : Image.file(
                          File(recipe.image),
                          height: 260,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => _errorImage(),
                        ),
                ),

                // Top bar — image ke upar overlay
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Back button
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Container(
                              width: 38,
                              height: 38,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.9),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.arrow_back,
                                  color: AppColors.textDark, size: 20),
                            ),
                          ),
                          // More options
                          Container(
                            width: 38,
                            height: 38,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.9),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.more_horiz,
                                color: AppColors.textDark, size: 20),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Rating badge
                Positioned(
                  top: 16,
                  right: 16,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5A623),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.star,
                            color: Colors.white, size: 13),
                        const SizedBox(width: 4),
                        Text(
                          recipe.rating.toStringAsFixed(1),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Time + bookmark at bottom of image — right side
                Positioned(
                  bottom: 14,
                  right: 16,
                  child: Row(
                    children: [
                      // Time pill
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.access_time,
                                color: Colors.white, size: 14),
                            const SizedBox(width: 5),
                            Text(
                              recipe.time,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      // Bookmark button
                      Consumer<SavedViewModel>(
                        builder: (context, savedVm, _) {
                          final saved = savedVm.isSaved(recipe.id);
                          return GestureDetector(
                            onTap: () {
                              context.read<HomeViewModel>().toggleSave(recipe.id);
                              
                              if (saved) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Removed from saved'),
                                    duration: Duration(seconds: 1),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Recipe saved!'),
                                    duration: Duration(seconds: 1),
                                    backgroundColor: AppColors.primary,
                                  ),
                                );
                              }
                            },
                            child: Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                color: saved
                                    ? AppColors.primary
                                    : Colors.black.withOpacity(0.5),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                saved
                                    ? Icons.bookmark
                                    : Icons.bookmark_border,
                                color: Colors.white,
                                size: 18,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ── Content ─────────────────────────────────────────────────
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
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textDark,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) =>
                                    ReviewsScreen(recipeId: recipe.id)),
                          );
                        },
                        child: Text(
                          '(${recipe.rating * 1000 ~/ 1}k Reviews)',
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.textGrey,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Author row
                  Row(
                    children: [
                      ClipOval(
                        child: recipe.authorImage.startsWith('assets/')
                            ? Image.asset(
                                recipe.authorImage,
                                width: 42,
                                height: 42,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => _authorError(),
                              )
                            : Image.file(
                                File(recipe.authorImage),
                                width: 42,
                                height: 42,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => _authorError(),
                              ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              recipe.author,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: AppColors.textDark,
                              ),
                            ),
                            Row(
                              children: const [
                                Icon(Icons.location_on,
                                    size: 12,
                                    color: AppColors.primary),
                                SizedBox(width: 3),
                                Text(
                                  'Pakistan',
                                  style: TextStyle(
                                      fontSize: 11,
                                      color: AppColors.textGrey),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // Follow button
                      GestureDetector(
                        onTap: () => vm.toggleFollow(),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                            color: vm.isFollowing
                                ? Colors.grey.shade200
                                : AppColors.primary,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            vm.isFollowing ? 'Following' : 'Follow',
                            style: TextStyle(
                              color: vm.isFollowing
                                  ? AppColors.textGrey
                                  : Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Ingredient / Procedure tabs
                  Row(
                    children: [
                      // Ingredient tab
                      GestureDetector(
                        onTap: vm.switchToIngredients,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
                          decoration: BoxDecoration(
                            color: vm.showIngredients
                                ? AppColors.primary
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Text(
                            'Ingredient',
                            style: TextStyle(
                              color: vm.showIngredients
                                  ? Colors.white
                                  : AppColors.primary,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      // Procedure tab
                      GestureDetector(
                        onTap: vm.switchToProcedure,
                        child: Text(
                          'Procedure',
                          style: TextStyle(
                            color: !vm.showIngredients
                                ? AppColors.primary
                                : AppColors.textGrey,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Serve info
                  if (vm.showIngredients)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: const [
                            Icon(Icons.person_outline,
                                size: 16, color: AppColors.textGrey),
                            SizedBox(width: 5),
                            Text('1 serve',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: AppColors.textGrey)),
                          ],
                        ),
                        Text(
                          '${vm.ingredients.length} items',
                          style: const TextStyle(
                              fontSize: 12, color: AppColors.textGrey),
                        ),
                      ],
                    ),
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
                    return _IngredientTile(ingredient: ing);
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
                    return _StepTile(
                        step: index + 1, text: vm.steps[index]);
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
