import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../utils/app_colors.dart';
import '../../../viewmodels/recipe_detail_viewmodel.dart';

class RecipeTabs extends StatelessWidget {
  const RecipeTabs({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<RecipeDetailViewModel>();

    return Column(
      children: [
        Row(
          children: [
            // Ingredient tab
            GestureDetector(
              onTap: vm.switchToIngredients,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                decoration: BoxDecoration(
                  color: vm.showIngredients
                      ? AppColors.primary
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Text(
                  'Ingredient',
                  style: TextStyle(
                    color: vm.showIngredients ? Colors.white : AppColors.textGrey,
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
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                decoration: BoxDecoration(
                  color: !vm.showIngredients
                      ? AppColors.primary
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Text(
                  'Procedure',
                  style: TextStyle(
                    color: !vm.showIngredients ? Colors.white : AppColors.textGrey,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
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
                  Icon(Icons.person_outline, size: 16, color: AppColors.textGrey),
                  SizedBox(width: 5),
                  Text('1 serve',
                      style: TextStyle(fontSize: 12, color: AppColors.textGrey)),
                ],
              ),
              Text(
                '${vm.ingredients.length} items',
                style: const TextStyle(fontSize: 12, color: AppColors.textGrey),
              ),
            ],
          ),
      ],
    );
  }
}
