import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/saved_viewmodel.dart';
import '../../models/recipe_model.dart';
import '../recipe/recipe_details_screen.dart';

const Color _primary = Color(0xFF1B8A6B);
const Color _accent = Color(0xFFF5A623);
const Color _cardBg = Color(0xFFF5F5F5);
const Color _textDark = Color(0xFF1A1A1A);
const Color _textGrey = Color(0xFF9E9E9E);
const Color _white = Color(0xFFFFFFFF);

class SavedScreen extends StatelessWidget {
  const SavedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<SavedViewModel>();

    return Material(
      color: _white,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── header ──────────────────────────────────────────────────
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 16),
              child: Text(
                'Saved Recipes',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: _textDark,
                ),
              ),
            ),

            // ── list ────────────────────────────────────────────────────
            Expanded(
              child: vm.savedRecipes.isEmpty
                  ? _emptyState()
                  : ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: vm.savedRecipes.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 14),
                      itemBuilder: (context, index) =>
                          _savedCard(context, vm.savedRecipes[index], vm),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  // ── empty state ─────────────────────────────────────────────────────────
  Widget _emptyState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.bookmark_border, size: 64, color: _textGrey),
          SizedBox(height: 16),
          Text(
            'No saved recipes yet',
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w600, color: _textDark),
          ),
          SizedBox(height: 8),
          Text(
            'Tap the bookmark icon on any recipe to save it',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 13, color: _textGrey),
          ),
        ],
      ),
    );
  }

  // ── saved card ──────────────────────────────────────────────────────────
  Widget _savedCard(BuildContext context, RecipeModel r, SavedViewModel vm) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RecipeDetailsScreen(recipe: r),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: _cardBg,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          children: [
            // image
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: r.image.startsWith('assets/')
                  ? Image.asset(
                      r.image,
                      width: 70,
                      height: 70,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => _recipeError(),
                    )
                  : Image.file(
                      File(r.image),
                      width: 70,
                      height: 70,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => _recipeError(),
                    ),
            ),
            const SizedBox(width: 14),

            // info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    r.name.replaceAll('\n', ' '),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: _textDark,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.star, size: 14, color: _accent),
                      const SizedBox(width: 4),
                      Text(
                        r.rating.toString(),
                        style: const TextStyle(fontSize: 12, color: _textGrey),
                      ),
                      const SizedBox(width: 12),
                      const Icon(Icons.access_time, size: 14, color: _textGrey),
                      const SizedBox(width: 4),
                      Text(
                        r.time,
                        style: const TextStyle(fontSize: 12, color: _textGrey),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    r.author,
                    style: const TextStyle(fontSize: 12, color: _textGrey),
                  ),
                ],
              ),
            ),

            // remove button
            GestureDetector(
              onTap: () => vm.removeRecipe(r.id),
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: _white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.bookmark,
                  size: 20,
                  color: _primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _recipeError() {
    return Container(
      width: 70,
      height: 70,
      color: _cardBg,
      alignment: Alignment.center,
      child: const Icon(
        Icons.image_not_supported,
        color: _textGrey,
      ),
    );
  }
}
