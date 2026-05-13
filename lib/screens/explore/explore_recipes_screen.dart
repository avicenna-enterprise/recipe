import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utils/app_colors.dart';
import '../../viewmodels/home_viewmodel.dart';
import '../../widgets/filter_bottom_sheet.dart';
import 'widgets/explore_recipe_card.dart';
import 'widgets/explore_search_bar.dart';

class ExploreRecipesScreen extends StatefulWidget {
  const ExploreRecipesScreen({super.key});

  @override
  State<ExploreRecipesScreen> createState() => _ExploreRecipesScreenState();
}

class _ExploreRecipesScreenState extends State<ExploreRecipesScreen> {
  final TextEditingController _searchCtrl = TextEditingController();
  String _query = '';

  // Filter state
  FilterSortOption _sort = FilterSortOption.newest;
  int _minRating = 0;
  String _category = 'All';

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<HomeViewModel>();
    final allRecipes = vm.allRecipes;

    // Filter logic
    var filtered = allRecipes.where((r) {
      final matchesQuery = _query.isEmpty ||
          r.name.toLowerCase().contains(_query.toLowerCase()) ||
          r.author.toLowerCase().contains(_query.toLowerCase());

      final matchesCategory = _category == 'All' || r.category == _category;
      final matchesRating = r.rating >= _minRating;

      return matchesQuery && matchesCategory && matchesRating;
    }).toList();

    // Sort logic
    if (_sort == FilterSortOption.popularity) {
      filtered.sort((a, b) => b.rating.compareTo(a.rating));
    } else if (_sort == FilterSortOption.oldest) {
      filtered = filtered.reversed.toList();
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textDark),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Explore Recipes',
          style: TextStyle(
            color: AppColors.textDark,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: Column(
        children: [
          // Search bar (Extracted Widget)
          ExploreSearchBar(
            controller: _searchCtrl,
            query: _query,
            onChanged: (v) => setState(() => _query = v),
            onClear: () {
              _searchCtrl.clear();
              setState(() => _query = '');
            },
            onFilterTap: () {
              showRecipeFilterBottomSheet(
                context: context,
                initial: FilterSelection(
                  sort: _sort,
                  minRating: _minRating,
                  category: _category,
                ),
                categories: vm.categories,
                onApply: (selection) {
                  setState(() {
                    _sort = selection.sort;
                    _minRating = selection.minRating;
                    _category = selection.category;
                  });
                },
              );
            },
          ),

          // Grid
          Expanded(
            child: filtered.isEmpty
                ? const Center(
                    child: Text('No recipes found',
                        style: TextStyle(color: AppColors.textGrey)))
                : GridView.builder(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 4),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.82,
                    ),
                    itemCount: filtered.length,
                    itemBuilder: (context, index) {
                      return ExploreRecipeCard(recipe: filtered[index]);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
