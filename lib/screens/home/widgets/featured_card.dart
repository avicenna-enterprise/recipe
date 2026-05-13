import 'package:flutter/material.dart';
import '../../../models/recipe_model.dart';
import '../../../utils/app_colors.dart';

class FeaturedCard extends StatelessWidget {
  final RecipeModel recipe;
  final VoidCallback onBookmark;
  final VoidCallback? onTap;

  const FeaturedCard({
    super.key,
    required this.recipe,
    required this.onBookmark,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
      width: 175,
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── image + rating badge ─────────────────────────────────────
          Stack(
            children: [
              Center(
                child: Container(
                  height: 120,
                  margin: const EdgeInsets.only(top: 10),
                  alignment: Alignment.center,
                  child: ClipOval(
                    child: Image.asset(
                      recipe.image,
                      width: 96,
                      height: 96,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        width: 96,
                        height: 96,
                        alignment: Alignment.center,
                        color: AppColors.cardBg,
                        child: const Icon(
                          Icons.image_not_supported,
                          color: AppColors.textGrey,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 16,
                right: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.accent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.star,
                          color: AppColors.white, size: 12),
                      const SizedBox(width: 3),
                      Text(
                        recipe.rating.toString(),
                        style: const TextStyle(
                          color: AppColors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // ── name ────────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 6, 14, 0),
            child: Text(
              recipe.name,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppColors.textDark,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),

          // ── time + bookmark ──────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 6, 14, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Time',
                        style: TextStyle(
                            color: AppColors.textGrey, fontSize: 11)),
                    const SizedBox(height: 2),
                    Text(
                      recipe.time,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                        color: AppColors.textDark,
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: onBookmark,
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      recipe.isSaved
                          ? Icons.bookmark
                          : Icons.bookmark_border,
                      size: 18,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      ),
    );
  }
}