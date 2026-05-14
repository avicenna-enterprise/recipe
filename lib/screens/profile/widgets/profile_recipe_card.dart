import 'dart:io';
import 'package:flutter/material.dart';
import '../../../models/recipe_model.dart';

class ProfileRecipeCard extends StatelessWidget {
  final RecipeModel recipe;
  final bool isSaved;
  final VoidCallback onTap;
  final VoidCallback onSave;
  final VoidCallback? onDelete;
  final VoidCallback? onEdit;

  const ProfileRecipeCard({
    super.key,
    required this.recipe,
    required this.isSaved,
    required this.onTap,
    required this.onSave,
    this.onDelete,
    this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            recipe.image.startsWith('assets/')
                ? Image.asset(
                    recipe.image,
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => _errorContainer(),
                  )
                : Image.file(
                    File(recipe.image),
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => _errorContainer(),
                  ),
            Container(
              height: 180,
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
            // Rating badge
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
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            // Actions buttons (Delete & Edit)
            if (onDelete != null || onEdit != null)
              Positioned(
                top: 10,
                left: 10,
                child: Row(
                  children: [
                    if (onDelete != null)
                      GestureDetector(
                        onTap: onDelete,
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          margin: const EdgeInsets.only(right: 8),
                          decoration: BoxDecoration(
                            color: Colors.red.withOpacity(0.8),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.delete_outline,
                              color: Colors.white, size: 18),
                        ),
                      ),
                    if (onEdit != null)
                      GestureDetector(
                        onTap: onEdit,
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.9),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.edit_outlined,
                              color: Color(0xFF1B8A6B), size: 18),
                        ),
                      ),
                  ],
                ),
              ),
            // Bottom info
            Positioned(
              left: 14,
              right: 14,
              bottom: 12,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          recipe.name.replaceAll('\n', ' '),
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              height: 1.3),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text('By ${recipe.author}',
                            style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 11)),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Row(
                    children: [
                      const Icon(Icons.access_time,
                          color: Colors.white70, size: 13),
                      const SizedBox(width: 4),
                      Text(recipe.time,
                          style: const TextStyle(
                              color: Colors.white70, fontSize: 11)),
                    ],
                  ),
                  const SizedBox(width: 8),
                  // Save button
                  GestureDetector(
                    onTap: onSave,
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: isSaved
                            ? const Color(0xFF1B8A6B)
                            : Colors.white.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        isSaved
                            ? Icons.bookmark
                            : Icons.bookmark_border,
                        color: Colors.white,
                        size: 16,
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

  Widget _errorContainer() {
    return Container(
      height: 180,
      color: const Color(0xFF2D6A4F),
      child: const Icon(Icons.restaurant, color: Colors.white54, size: 50),
    );
  }
}
