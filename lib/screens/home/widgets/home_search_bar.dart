import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../utils/app_colors.dart';
import '../../../viewmodels/home_viewmodel.dart';
import '../../../widgets/filter_bottom_sheet.dart';

class HomeSearchBar extends StatefulWidget {
  const HomeSearchBar({super.key});

  @override
  State<HomeSearchBar> createState() => _HomeSearchBarState();
}

class _HomeSearchBarState extends State<HomeSearchBar> {
  late final TextEditingController _ctrl;
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    final q = context.read<HomeViewModel>().searchQuery;
    _ctrl = TextEditingController(text: q);
    _hasText = q.isNotEmpty;
    _ctrl.addListener(() {
      setState(() => _hasText = _ctrl.text.isNotEmpty);
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 52,
            decoration: BoxDecoration(
              color: AppColors.cardBg,
              borderRadius: BorderRadius.circular(30),
            ),
            child: TextField(
              controller: _ctrl,
              onChanged: context.read<HomeViewModel>().updateSearchQuery,
              decoration: InputDecoration(
                hintText: 'Search recipe',
                hintStyle: const TextStyle(color: AppColors.textGrey, fontSize: 15),
                prefixIcon: const Icon(Icons.search, color: AppColors.textGrey),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 16),
                suffixIcon: _hasText
                    ? IconButton(
                        tooltip: 'Clear',
                        icon: const Icon(Icons.close, color: AppColors.textGrey),
                        onPressed: () {
                          _ctrl.clear();
                          context.read<HomeViewModel>().updateSearchQuery('');
                        },
                      )
                    : null,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: () {
            showRecipeFilterBottomSheet(
              context: context,
              initial: const FilterSelection(
                sort: FilterSortOption.newest,
                minRating: 0,
                category: 'All',
              ),
              categories: const ['All'],
              onApply: (_) {},
            );
          },
          child: Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(Icons.tune, color: AppColors.white, size: 22),
          ),
        ),
      ],
    );
  }
}