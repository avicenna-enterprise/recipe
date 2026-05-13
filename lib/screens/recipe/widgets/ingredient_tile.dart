import 'package:flutter/material.dart';
import '../../../models/ingredient_model.dart';
import '../../../utils/app_colors.dart';

class IngredientTile extends StatelessWidget {
  final IngredientModel ingredient;

  const IngredientTile({super.key, required this.ingredient});

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
