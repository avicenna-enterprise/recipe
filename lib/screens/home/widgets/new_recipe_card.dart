import 'dart:io';
import 'package:flutter/material.dart';
import '../../../models/recipe_model.dart';
import '../../../utils/app_colors.dart';

class NewRecipeCard extends StatelessWidget {
  final RecipeModel recipe;
  final VoidCallback? onTap;

  const NewRecipeCard({super.key, required this.recipe, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 260,
        margin: const EdgeInsets.only(top: 25, right: 16, bottom: 5),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // ── card body ──────────────────────────────────────────────────
            Container(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // name
                  SizedBox(
                    width: 140,
                    child: Text(
                      recipe.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Color(0xFF333333),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 6),
                  // stars
                  Row(
                    children: List.generate(5, (i) {
                      return Icon(
                        Icons.star,
                        size: 14,
                        color: i < recipe.rating.floor()
                            ? const Color(0xFFFFB800)
                            : const Color(0xFFE0E0E0),
                      );
                    }),
                  ),
                  const Spacer(),
                  // author + time
                  Row(
                    children: [
                      ClipOval(
                        child: recipe.authorImage.startsWith('assets/')
                            ? Image.asset(
                                recipe.authorImage,
                                width: 25,
                                height: 25,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => _authorError(),
                              )
                            : Image.file(
                                File(recipe.authorImage),
                                width: 25,
                                height: 25,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => _authorError(),
                              ),
                      ),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          recipe.author,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Icon(Icons.access_time, size: 14, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(
                        recipe.time,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // ── pop-out image ──────────────────────────────────────────────
            Positioned(
              top: -25,
              right: 15,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: ClipOval(
                  child: recipe.image.startsWith('assets/')
                      ? Image.asset(
                          recipe.image,
                          width: 85,
                          height: 85,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => _recipeError(),
                        )
                      : Image.file(
                          File(recipe.image),
                          width: 85,
                          height: 85,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => _recipeError(),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _authorError() {
    return Container(
      width: 22,
      height: 22,
      color: AppColors.cardBg,
      alignment: Alignment.center,
      child: const Icon(
        Icons.person,
        size: 14,
        color: AppColors.textGrey,
      ),
    );
  }

  Widget _recipeError() {
    return Container(
      width: 65,
      height: 65,
      color: AppColors.cardBg,
      alignment: Alignment.center,
      child: const Icon(
        Icons.image_not_supported,
        color: AppColors.textGrey,
      ),
    );
  }
}