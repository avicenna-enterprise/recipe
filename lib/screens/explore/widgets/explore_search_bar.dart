import 'package:flutter/material.dart';
import '../../../utils/app_colors.dart';

class ExploreSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final String query;
  final ValueChanged<String> onChanged;
  final VoidCallback onClear;
  final VoidCallback onFilterTap;

  const ExploreSearchBar({
    super.key,
    required this.controller,
    required this.query,
    required this.onChanged,
    required this.onClear,
    required this.onFilterTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(30),
              ),
              child: TextField(
                controller: controller,
                onChanged: onChanged,
                decoration: InputDecoration(
                  hintText: 'Search recipe',
                  hintStyle: const TextStyle(
                      color: AppColors.textGrey, fontSize: 14),
                  prefixIcon: const Icon(Icons.search,
                      color: AppColors.textGrey),
                  suffixIcon: query.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.close,
                              color: AppColors.textGrey, size: 18),
                          onPressed: onClear,
                        )
                      : null,
                  border: InputBorder.none,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: onFilterTap,
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(Icons.tune,
                  color: Colors.white, size: 22),
            ),
          ),
        ],
      ),
    );
  }
}
