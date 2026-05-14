import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

enum FilterSortOption { newest, oldest, popularity, all }

class FilterSelection {
  final FilterSortOption sort;
  final int minRating; // 0..5
  final String category; // "All" or any

  const FilterSelection({
    required this.sort,
    required this.minRating,
    required this.category,
  });
}

Future<void> showRecipeFilterBottomSheet({
  required BuildContext context,
  required FilterSelection initial,
  required List<String> categories,
  required ValueChanged<FilterSelection> onApply,
}) async {
  await showModalBottomSheet<void>(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (context) {
      FilterSortOption sort = initial.sort;
      int minRating = initial.minRating;
      String category = initial.category;

      Widget chip({
        required bool selected,
        required Widget child,
        required VoidCallback onTap,
      }) {
        return InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 160),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: selected ? AppColors.primary : Colors.transparent,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: AppColors.primary.withValues(alpha: 0.35)),
            ),
            child: DefaultTextStyle(
              style: TextStyle(
                color: selected ? AppColors.white : AppColors.primary,
                fontWeight: FontWeight.w600,
                fontSize: 12.5,
              ),
              child: child,
            ),
          ),
        );
      }

      return StatefulBuilder(
        builder: (context, setState) {
          return SafeArea(
            child: Container(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 20),
              decoration: const BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 42,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(999),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Center(
                    child: Text(
                      'Filter Search',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  const Text(
                    'Time',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      chip(
                        selected: sort == FilterSortOption.all,
                        onTap: () => setState(() => sort = FilterSortOption.all),
                        child: const Text('All'),
                      ),
                      chip(
                        selected: sort == FilterSortOption.newest,
                        onTap: () => setState(() => sort = FilterSortOption.newest),
                        child: const Text('Newest'),
                      ),
                      chip(
                        selected: sort == FilterSortOption.oldest,
                        onTap: () => setState(() => sort = FilterSortOption.oldest),
                        child: const Text('Oldest'),
                      ),
                      chip(
                        selected: sort == FilterSortOption.popularity,
                        onTap: () => setState(() => sort = FilterSortOption.popularity),
                        child: const Text('Popularity'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  const Text(
                    'Rate',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: List.generate(5, (i) {
                      final value = 5 - i; // 5..1
                      final selected = minRating == value;
                      return chip(
                        selected: selected,
                        onTap: () => setState(() => minRating = value),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('$value'),
                            const SizedBox(width: 4),
                            const Icon(Icons.star, size: 14),
                          ],
                        ),
                      );
                    })
                      ..add(
                        chip(
                          selected: minRating == 0,
                          onTap: () => setState(() => minRating = 0),
                          child: const Text('All'),
                        ),
                      ),
                  ),
                  const SizedBox(height: 18),
                  const Text(
                    'Category',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: categories.map((c) {
                      final selected = category == c;
                      return chip(
                        selected: selected,
                        onTap: () => setState(() => category = c),
                        child: Text(c),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 22),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: AppColors.white,
                      ),
                      onPressed: () {
                        onApply(
                          FilterSelection(
                            sort: sort,
                            minRating: minRating,
                            category: category,
                          ),
                        );
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        'Filter',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}