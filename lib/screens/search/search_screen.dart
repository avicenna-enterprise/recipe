import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utils/app_colors.dart';
import '../../viewmodels/search_viewmodel.dart';
import 'widgets/search_recipe_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _ctrl = TextEditingController();
  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) {
    final vm = context.watch<SearchViewModel>();
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.maybePop(context),
                    child: const Icon(Icons.arrow_back, color: AppColors.textDark, size: 24),
                  ),
                  const Expanded(child: Center(child: Text('Search recipes', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textDark)))),
                  const SizedBox(width: 24),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 52,
                      decoration: BoxDecoration(color: AppColors.cardBg, borderRadius: BorderRadius.circular(30)),
                      child: TextField(
                        controller: _ctrl,
                        autofocus: true,
                        onChanged: vm.updateQuery,
                        onSubmitted: vm.addRecentSearch,
                        decoration: const InputDecoration(
                          hintText: 'Search recipe',
                          hintStyle: TextStyle(color: AppColors.textGrey, fontSize: 15),
                          prefixIcon: Icon(Icons.search, color: AppColors.textGrey),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 16),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    width: 52, height: 52,
                    decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(14)),
                    child: const Icon(Icons.tune, color: AppColors.white, size: 22),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(vm.query.isEmpty ? 'Recent Search' : 'Results', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textDark)),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: vm.results.isEmpty
                  ? const Center(child: Text('No recipes found', style: TextStyle(color: AppColors.textGrey, fontSize: 15)))
                  : GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 12, mainAxisSpacing: 12, childAspectRatio: 0.85),
                itemCount: vm.results.length,
                itemBuilder: (context, index) => SearchRecipeCard(recipe: vm.results[index]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}