import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/recipe_model.dart';
import '../../../utils/app_colors.dart';
import '../../../viewmodels/home_viewmodel.dart';
import '../../../viewmodels/saved_viewmodel.dart';

class RecipeHero extends StatelessWidget {
  final RecipeModel recipe;
  final VoidCallback onMoreTap;

  const RecipeHero({
    super.key,
    required this.recipe,
    required this.onMoreTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Top Navigation Bar
        SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.arrow_back, color: AppColors.textDark),
                ),
                GestureDetector(
                  onTap: onMoreTap,
                  child: const Icon(Icons.more_horiz, color: AppColors.textDark),
                ),
              ],
            ),
          ),
        ),

        // Hero Image Card
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Stack(
            children: [
              // The Image
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  recipe.image,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 200,
                    color: AppColors.primary.withValues(alpha: 0.1),
                    child: const Icon(Icons.restaurant,
                        color: AppColors.primary, size: 60),
                  ),
                ),
              ),

              // Subtle gradient overlay for readability
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.0),
                        Colors.black.withOpacity(0.8),
                      ],
                      stops: const [0.4, 1.0],
                    ),
                  ),
                ),
              ),

              // Rating badge (Top-Right)
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFE1B3),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.star,
                          color: Color(0xFFF5A623), size: 12),
                      const SizedBox(width: 4),
                      Text(
                        recipe.rating.toStringAsFixed(1),
                        style: const TextStyle(
                          color: AppColors.textDark,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Time + Bookmark (Bottom-Right)
              Positioned(
                bottom: 12,
                right: 12,
                child: Row(
                  children: [
                    // Time
                    Row(
                      children: [
                        const Icon(Icons.access_time,
                            color: Colors.white, size: 16),
                        const SizedBox(width: 5),
                        Text(
                          recipe.time,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 12),
                    // Bookmark button
                    Consumer<SavedViewModel>(
                      builder: (context, savedVm, _) {
                        final saved = savedVm.isSaved(recipe.id);
                        return GestureDetector(
                          onTap: () {
                            context.read<HomeViewModel>().toggleSave(recipe.id);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(saved
                                    ? 'Removed from saved'
                                    : 'Recipe saved!'),
                                duration: const Duration(seconds: 1),
                                backgroundColor:
                                    saved ? Colors.red : AppColors.primary,
                              ),
                            );
                          },
                          child: Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: saved ? AppColors.primary : Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              saved ? Icons.bookmark : Icons.bookmark_border,
                              color: saved ? Colors.white : AppColors.primary,
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
      ],
    );
  }
}
