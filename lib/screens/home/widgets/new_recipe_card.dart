import 'package:flutter/material.dart';
import '../../../models/recipe_model.dart';
import '../../../utils/app_colors.dart';

class NewRecipeCard extends StatelessWidget {
  final RecipeModel recipe;

  const NewRecipeCard({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // name
                Text(
                  recipe.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: AppColors.textDark,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),

                // stars
                Row(
                  children: List.generate(5, (i) {
                    return Icon(
                      Icons.star,
                      size: 14,
                      color: i < recipe.rating.floor()
                          ? AppColors.accent
                          : AppColors.cardBg,
                    );
                  }),
                ),
                const SizedBox(height: 8),

                // author + time
                Row(
                  children: [
                    ClipOval(
                      child: Image.asset(
                        recipe.authorImage,
                        width: 22,
                        height: 22,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          width: 22,
                          height: 22,
                          color: AppColors.cardBg,
                          alignment: Alignment.center,
                          child: const Icon(
                            Icons.person,
                            size: 14,
                            color: AppColors.textGrey,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        recipe.author,
                        style: const TextStyle(
                            fontSize: 11, color: AppColors.textGrey),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.access_time,
                        size: 12, color: AppColors.textGrey),
                    const SizedBox(width: 3),
                    Text(
                      recipe.time,
                      style: const TextStyle(
                          fontSize: 11, color: AppColors.textGrey),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),

          // image
          ClipOval(
            child: Image.asset(
              recipe.image,
              width: 65,
              height: 65,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: 65,
                height: 65,
                color: AppColors.cardBg,
                alignment: Alignment.center,
                child: const Icon(
                  Icons.image_not_supported,
                  color: AppColors.textGrey,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}