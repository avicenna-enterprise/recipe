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
        width: 150, // Slightly narrower for premium feel
        margin: const EdgeInsets.only(right: 16),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // ── card background ──────────────────────────────────────────
            Container(
              margin: const EdgeInsets.only(top: 50),
              height: 175, // Taller background as per image
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFFF1F1F1),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 70), // More space for image overflow
                  // ── name ──────────────────────────────────────────────────
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: Text(
                      recipe.name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF333333),
                        height: 1.1,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const Spacer(),
                  // ── bottom row (time + bookmark) ─────────────────────────
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              'Time',
                              style: TextStyle(
                                color: Color(0xFFAAAAAA),
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              recipe.time,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Color(0xFF333333),
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        // Bookmark Button
                        GestureDetector(
                          onTap: onBookmark,
                          child: Container(
                            width: 36,
                            height: 36,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 6,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Icon(
                              recipe.isSaved
                                  ? Icons.bookmark
                                  : Icons.bookmark_border,
                              size: 20,
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
            // ── overlapping image + rating ──────────────────────────────
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Center(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    // circular image
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.12),
                            blurRadius: 12,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          recipe.image,
                          width: 95, // Slightly larger image
                          height: 95,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(
                            width: 95,
                            height: 95,
                            color: Colors.white,
                            child: const Icon(Icons.restaurant, color: Colors.grey, size: 40),
                          ),
                        ),
                      ),
                    ),
                    // rating badge
                    Positioned(
                      right: -8,
                      top: 15,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 2),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFE1B3),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.star,
                                color: Color(0xFFFFB800), size: 9),
                            const SizedBox(width: 2),
                            Text(
                              recipe.rating.toString(),
                              style: const TextStyle(
                                color: Color(0xFF333333),
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}