import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/recipe_model.dart';
import '../../../utils/app_colors.dart';
import '../../../viewmodels/home_viewmodel.dart';
import '../../../viewmodels/saved_viewmodel.dart';
import 'recipe_details_dialogs.dart';

void showRecipeOptionsMenu(BuildContext context, RecipeModel recipe) {
  // Find the button's position
  final RenderBox button = context.findRenderObject() as RenderBox;
  final RenderBox overlay =
      Overlay.of(context).context.findRenderObject() as RenderBox;

  final RelativeRect position = RelativeRect.fromRect(
    Rect.fromPoints(
      button.localToGlobal(button.size.topRight(Offset.zero), ancestor: overlay),
      button.localToGlobal(button.size.bottomRight(Offset.zero),
          ancestor: overlay),
    ),
    Offset.zero & overlay.size,
  );

  final savedVm = context.read<SavedViewModel>();
  final homeVm = context.read<HomeViewModel>();
  final isSaved = savedVm.isSaved(recipe.id);

  showMenu(
    context: context,
    position: position,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    elevation: 8,
    items: [
      _buildMenuItem(Icons.reply, 'share', () {
        Future.delayed(Duration.zero, () => showShareDialog(context, recipe));
      }),
      _buildMenuItem(Icons.star_outline, 'Rate Recipe', () {
        Future.delayed(Duration.zero, () => showRateDialog(context));
      }),
      _buildMenuItem(Icons.chat_bubble_outline, 'Review', () {
        // Review logic
      }),
      _buildMenuItem(isSaved ? Icons.bookmark : Icons.bookmark_border,
          isSaved ? 'Unsave' : 'Save', () {
        homeVm.toggleSave(recipe.id);
      }),
    ],
  );
}

PopupMenuItem _buildMenuItem(IconData icon, String text, VoidCallback onTap) {
  return PopupMenuItem(
    onTap: onTap,
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 20, color: AppColors.textDark),
        const SizedBox(width: 14),
        Text(
          text,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.textDark,
          ),
        ),
      ],
    ),
  );
}
