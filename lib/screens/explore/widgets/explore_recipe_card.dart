import 'dart:io';
import 'package:flutter/material.dart';
import '../../../models/recipe_model.dart';
import '../../../utils/recipe_navigator.dart';

class ExploreRecipeCard extends StatelessWidget {
  final RecipeModel recipe;

  const ExploreRecipeCard({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => openRecipeDetail(context, recipe),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          fit: StackFit.expand,
          children: [
            recipe.image.startsWith('assets/')
                ? Image.asset(
                    recipe.image,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => _buildErrorImage(),
                  )
                : Image.file(
                    File(recipe.image),
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => _buildErrorImage(),
                  ),

            // Dark gradient overlay
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.75),
                  ],
                ),
              ),
            ),

            // Rating badge top right
            Positioned(
              top: 10,
              right: 10,
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5A623),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.star,
                        color: Colors.white, size: 12),
                    const SizedBox(width: 3),
                    Text(
                      recipe.rating.toStringAsFixed(1),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Recipe name + chef at bottom
            Positioned(
              left: 10,
              right: 10,
              bottom: 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    recipe.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      height: 1.3,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'By ${recipe.author}',
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 11,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorImage() {
    return Container(
      color: const Color(0xFF2D6A4F),
      child: const Icon(Icons.restaurant, color: Colors.white54, size: 40),
    );
  }
}
