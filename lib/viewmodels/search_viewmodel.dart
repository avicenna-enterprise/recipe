import 'package:flutter/material.dart';
import '../models/recipe_model.dart';
import '../widgets/filter_bottom_sheet.dart';

class SearchViewModel extends ChangeNotifier {
  String _query = '';
  final List<String> _recentSearches = [];

  FilterSortOption _sort = FilterSortOption.newest;
  int _minRating = 0;
  String _category = 'All';

  final List<String> filterCategories = const [
    'All',
    'Cereal',
    'Vegetables',
    'Dinner',
    'Chinese',
    'Local Dish',
    'Fruit',
    'Breakfast',
    'Spanish',
    'Lunch',
  ];

  // ── all recipes (search pool) ─────────────────────────────────────────────
  final List<RecipeModel> _allRecipes = [
    RecipeModel(
      id: 's1',
      name: 'Traditional spare ribs baked',
      image: 'assets/images/Traditional spare ribs baked.png',
      rating: 4.0,
      time: '30 mins',
      author: 'By Chef John',
      authorImage: 'assets/images/classic_greek_salad.png',
      category: 'Dinner',
    ),
    RecipeModel(
      id: 's2',
      name: 'Lamb chops with fruity couscous and mint...',
      image: 'assets/images/lamb_chops_with_fruity.png',
      rating: 4.0,
      time: '25 mins',
      author: 'By Spicy Nelly',
      authorImage: 'assets/images/classic_greek_salad.png',
      category: 'Dinner',
    ),
    RecipeModel(
      id: 's3',
      name: 'Spice roasted chicken with flavored rice',
      image: 'assets/images/spice_roasted_chicken.png',
      rating: 4.0,
      time: '40 mins',
      author: 'By Mark Kelvin',
      authorImage: 'assets/images/classic_greek_salad.png',
      category: 'Local Dish',
    ),
    RecipeModel(
      id: 's4',
      name: 'Chinese style Egg fried rice with sliced pork...',
      image: 'assets/images/Chinese_style_Egg_fried_rice.png',
      rating: 4.0,
      time: '20 mins',
      author: 'By Laura Wilson',
      authorImage: 'assets/images/classic_greek_salad.png',
      category: 'Chinese',
    ),
    RecipeModel(
      id: 's5',
      name: 'Lamb chops with fruity couscous and mint...',
      image: 'assets/images/Lamb_chops.png',
      rating: 4.0,
      time: '25 mins',
      author: 'By Spicy Nelly',
      authorImage: 'assets/images/classic_greek_salad.png',
      category: 'Dinner',
    ),
    RecipeModel(
      id: 's6',
      name: 'Traditional spare ribs baked',
      image: 'assets/images/Traditional spare.png',
      rating: 4.0,
      time: '30 mins',
      author: 'By Chef John',
      authorImage: 'assets/images/classic_greek_salad.png',
      category: 'Dinner',
    ),
    RecipeModel(
      id: 's7',
      name: 'Classic Greek Salad',
      image: 'assets/images/classic_greek_salad.png',
      rating: 4.5,
      time: '15 mins',
      author: 'By Chef Ali',
      authorImage: 'assets/images/classic_greek_salad.png',
      category: 'Vegetables',
    ),
    RecipeModel(
      id: 's8',
      name: 'Crunchy Nut Coleslaw',
      image: 'assets/images/crunchy_nut_coleslaw.png',
      rating: 3.5,
      time: '10 mins',
      author: 'By Chef Sara',
      authorImage: 'assets/images/classic_greek_salad.png',
      category: 'Vegetables',
    ),
  ];

  // ── getters ───────────────────────────────────────────────────────────────
  String get query => _query;
  List<String> get recentSearches => _recentSearches;
  FilterSortOption get sort => _sort;
  int get minRating => _minRating;
  String get category => _category;

  List<RecipeModel> get results {
    final q = _query.trim().toLowerCase();
    Iterable<RecipeModel> list = _allRecipes;

    if (q.isNotEmpty) {
      list = list.where((r) => r.name.toLowerCase().contains(q));
    }

    if (_category != 'All') {
      list = list.where((r) => r.category == _category);
    }

    if (_minRating > 0) {
      list = list.where((r) => r.rating >= _minRating);
    }

    final out = list.toList();
    switch (_sort) {
      case FilterSortOption.newest:
        out.sort((a, b) => b.id.compareTo(a.id));
        break;
      case FilterSortOption.oldest:
        out.sort((a, b) => a.id.compareTo(b.id));
        break;
      case FilterSortOption.popularity:
        out.sort((a, b) => b.rating.compareTo(a.rating));
        break;
    }
    return out;
  }

  // ── actions ───────────────────────────────────────────────────────────────
  void updateQuery(String value) {
    _query = value;
    notifyListeners();
  }

  void applyFilters({
    required FilterSortOption sort,
    required int minRating,
    required String category,
  }) {
    _sort = sort;
    _minRating = minRating;
    _category = category;
    notifyListeners();
  }

  void addRecentSearch(String term) {
    if (term.isNotEmpty && !_recentSearches.contains(term)) {
      _recentSearches.insert(0, term);
      if (_recentSearches.length > 5) _recentSearches.removeLast();
    }
    notifyListeners();
  }

  void clearQuery() {
    _query = '';
    notifyListeners();
  }
}