import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/recipe_model.dart';
import '../../../utils/app_colors.dart';
import '../../../viewmodels/recipe_detail_viewmodel.dart';

class AuthorInfo extends StatelessWidget {
  final RecipeModel recipe;

  const AuthorInfo({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<RecipeDetailViewModel>();

    return Row(
      children: [
        ClipOval(
          child: recipe.authorImage.startsWith('assets/')
              ? Image.asset(
                  recipe.authorImage,
                  width: 42,
                  height: 42,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      _buildErrorIcon(),
                )
              : Image.file(
                  File(recipe.authorImage),
                  width: 42,
                  height: 42,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      _buildErrorIcon(),
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
                children: [
                  const Icon(Icons.location_on,
                      size: 12, color: AppColors.primary),
                  const SizedBox(width: 3),
                  Text(
                    recipe.authorLocation,
                    style:
                        const TextStyle(fontSize: 12, color: AppColors.textGrey),
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
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color:
                  vm.isFollowing ? Colors.grey.shade200 : AppColors.primary,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              vm.isFollowing ? 'Following' : 'Follow',
              style: TextStyle(
                color: vm.isFollowing ? AppColors.textGrey : Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildErrorIcon() {
    return Container(
      width: 42,
      height: 42,
      color: AppColors.cardBg,
      child: const Icon(Icons.person, color: AppColors.textGrey),
    );
  }
}
