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

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<HomeViewModel>();
    final allRecipes = vm.allRecipes;

    final filtered = _query.trim().isEmpty
        ? allRecipes
        : allRecipes
            .where((r) =>
                r.name.toLowerCase().contains(_query.toLowerCase()) ||
                r.author.toLowerCase().contains(_query.toLowerCase()))
            .toList();

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
          // Search bar
          Padding(
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
                      controller: _searchCtrl,
                      onChanged: (v) => setState(() => _query = v),
                      decoration: InputDecoration(
                        hintText: 'Search recipe',
                        hintStyle: const TextStyle(
                            color: AppColors.textGrey, fontSize: 14),
                        prefixIcon: const Icon(Icons.search,
                            color: AppColors.textGrey),
                        suffixIcon: _query.isNotEmpty
                            ? IconButton(
                                icon: const Icon(Icons.close,
                                    color: AppColors.textGrey, size: 18),
                                onPressed: () {
                                  _searchCtrl.clear();
                                  setState(() => _query = '');
                                },
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
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Icon(Icons.tune,
                      color: Colors.white, size: 22),
                ),
              ],
            ),
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