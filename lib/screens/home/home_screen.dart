import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utils/app_colors.dart';
import '../../utils/recipe_navigator.dart';
import '../../viewmodels/home_viewmodel.dart';
import 'widgets/home_header.dart';
import 'widgets/home_search_bar.dart';
import 'widgets/category_tabs.dart';
import 'widgets/featured_card.dart';
import 'widgets/new_recipe_card.dart';
import '../search/widgets/search_recipe_card.dart';

class HomeScreen extends StatelessWidget {
const HomeScreen({super.key});

@override
Widget build(BuildContext context) {
final vm = context.watch<HomeViewModel>();

return Scaffold(
backgroundColor: AppColors.background,
body: SafeArea(
child: SingleChildScrollView(
padding: const EdgeInsets.symmetric(horizontal: 20),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
const SizedBox(height: 20),

// ── header ──────────────────────────────────────────────
HomeHeader(user: vm.user),
const SizedBox(height: 24),

// ── search bar ──────────────────────────────────────────
const HomeSearchBar(),
const SizedBox(height: 24),

// ── category tabs ───────────────────────────────────────
CategoryTabs(
categories: vm.categories,
selectedIndex: vm.selectedCategory,
onTap: vm.selectCategory,
),
const SizedBox(height: 24),

if (vm.searchQuery.trim().isNotEmpty) ...[
Text(
'Results',
style: const TextStyle(
fontSize: 20,
fontWeight: FontWeight.bold,
color: AppColors.textDark,
),
),
const SizedBox(height: 16),
vm.searchResults.isEmpty
? const Padding(
padding: EdgeInsets.symmetric(vertical: 30),
child: Center(
child: Text(
'No recipes found',
style: TextStyle(color: AppColors.textGrey, fontSize: 15),
),
),
)
    : GridView.builder(
shrinkWrap: true,
physics: const NeverScrollableScrollPhysics(),
gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
crossAxisCount: 2,
crossAxisSpacing: 12,
mainAxisSpacing: 12,
childAspectRatio: 0.85,
),
itemCount: vm.searchResults.length,
itemBuilder: (_, index) {
final recipe = vm.searchResults[index];
return SearchRecipeCard(recipe: recipe);
},
),
const SizedBox(height: 20),
] else ...[
// ── featured recipes ────────────────────────────────────
SizedBox(
height: 280,
child: ListView.separated(
scrollDirection: Axis.horizontal,
itemCount: vm.featured.length,
separatorBuilder: (context, index) => const SizedBox(width: 16),
itemBuilder: (_, index) {
final recipe = vm.featured[index];
return FeaturedCard(
recipe: recipe,
onBookmark: () => vm.toggleSave(recipe.id),
onTap: () => openRecipeDetail(context, recipe),
);
},
),
),
const SizedBox(height: 28),

// ── new recipes ─────────────────────────────────────────
const Text(
'New Recipes',
style: TextStyle(
fontSize: 20,
fontWeight: FontWeight.bold,
color: AppColors.textDark,
),
),
const SizedBox(height: 16),
SizedBox(
height: 100,
child: ListView.separated(
scrollDirection: Axis.horizontal,
itemCount: vm.newRecipes.length,
separatorBuilder: (context, index) => const SizedBox(width: 14),
itemBuilder: (_, index) {
final recipe = vm.newRecipes[index];
return NewRecipeCard(recipe: recipe);
},
),
),
const SizedBox(height: 20),
],
],
),
),
),
);
}
}