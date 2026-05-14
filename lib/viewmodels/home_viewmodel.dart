import 'package:flutter/material.dart';
import '../models/recipe_model.dart';
import '../models/user_model.dart';
import '../models/video_model.dart';
import 'saved_viewmodel.dart';

class HomeViewModel extends ChangeNotifier {

  SavedViewModel? _savedViewModel;
  String _searchQuery = '';
  final List<VideoModel> _userVideos = [];

  void setSavedViewModel(SavedViewModel vm) {
    _savedViewModel = vm;
    // When saved state changes, notify home to rebuild
    _savedViewModel!.onSaveStateChanged = () {
      notifyListeners();
    };
  }

  UserModel _user = UserModel(
    id: '1',
    name: 'Ayesha',
    email: 'ayesha@email.com',
  );

  int _selectedCategory = 0;

  final List<String> categories = [
    'All', 'Indian', 'Italian', 'Asian', 'Chinese',
  ];

  // ── featured recipes ──────────────────────────────────────────────────────
  final List<RecipeModel> _featured = [
    RecipeModel(
      id: '1',
      name: 'Chicken Biryani',
      image: 'assets/images/biryani.jpeg',
      rating: 4.7,
      time: '45 mins',
      author: 'Chef Ayesha',
      authorImage: 'assets/images/biryani.jpeg',
      category: 'Indian',
      isSaved: false,
      videoUrl: 'https://youtube.com/shorts/PIcngQCMOPE?si=EbLP15vd1gDHQ9fr',
    ),
    RecipeModel(
      id: '2',
      name: 'Hotpot Special',
      image: 'assets/images/hotpot.jpeg',
      rating: 4.4,
      time: '35 mins',
      author: 'Chef Li',
      authorImage: 'assets/images/hotpot.jpeg',
      category: 'Chinese',
      isSaved: false,
      videoUrl: 'https://youtube.com/shorts/euBRSSJj3Ho?si=-Dz7ndOEmRs2cQfb',
    ),
    RecipeModel(
      id: '5',
      name: 'Grilled Chicken',
      image: 'assets/images/chicken.jpeg',
      rating: 4.3,
      time: '25 mins',
      author: 'Chef Daniel',
      authorImage: 'assets/images/chicken.jpeg',
      category: 'Asian',
      isSaved: false,
      videoUrl: 'https://youtube.com/shorts/L-rJQVT24Zo?si=nwGzn2AQmsBgwPeZ',
    ),
    RecipeModel(
      id: '6',
      name: 'Italian Food',
      image: 'assets/images/italian_food.jpeg',
      rating: 4.6,
      time: '30 mins',
      author: 'Chef Marco',
      authorImage: 'assets/images/italian_food.jpeg',
      category: 'Italian',
      isSaved: false,
      videoUrl: 'https://youtube.com/shorts/gcXcB_Sl4uw?si=U_rDv4RhEMVBIIf_',
    ),
    RecipeModel(
      id: '9',
      name: 'Crunchy Nut Coleslaw',
      image: 'assets/images/crunchy_nut_coleslaw.jpeg',
      rating: 3.5,
      time: '10 mins',
      author: 'Chef Sara',
      authorImage: 'assets/images/crunchy_nut_coleslaw.jpeg',
      category: 'Asian',
      isSaved: false,
      videoUrl: 'https://youtube.com/shorts/QmDPIGkmdLc?si=ZUFjHr2VnQkadZM6',
    ),
    RecipeModel(
      id: '10',
      name: 'Classic Greek Salad',
      image: 'assets/images/classic_greek_salad.jpeg',
      rating: 4.5,
      time: '15 mins',
      author: 'Chef Ali',
      authorImage: 'assets/images/classic_greek_salad.jpeg',
      category: 'Italian',
      isSaved: false,
      videoUrl: 'https://youtube.com/shorts/oSn0Y9c99NU?si=4-luEwnh_Nz0x9QD',
    ),
  ];

  // ── new recipes ───────────────────────────────────────────────────────────
  final List<RecipeModel> _newRecipes = [
    RecipeModel(
      id: '3',
      name: 'Polina Special',
      image: 'assets/images/polina_Tankilevitch.jpeg',
      rating: 4.5,
      time: '20 mins',
      author: 'Chef Sofia',
      authorImage: 'assets/images/polina_Tankilevitch.jpeg',
      category: 'Italian',
      isSaved: false,
      videoUrl: 'https://youtube.com/shorts/a5_dXfrkHt4?si=kcK9mAa283uW3vHN',
    ),



    RecipeModel(
      id: '11',
      name: 'Spice Roasted Chicken',
      image: 'assets/images/spice_roasted_chicken.jpeg',
      rating: 4.0,
      time: '40 mins',
      author: 'Mark Kelvin',
      authorImage: 'assets/images/spice_roasted_chicken.jpeg',
      category: 'Asian',
      isSaved: false,
      videoUrl: 'https://youtube.com/shorts/827IZsbsZj8?si=mYMxkgQeEF_U0fep',
    ),
    RecipeModel(
      id: '12',
      name: 'Steak with Tomato',
      image: 'assets/images/steak_with_tomatto.jpeg',
      rating: 4.0,
      time: '35 mins',
      author: 'Chef John',
      authorImage: 'assets/images/steak_with_tomatto.jpeg',
      category: 'Italian',
      isSaved: false,
      videoUrl: 'https://youtube.com/shorts/vKh2ym0XLTY?si=nzCnIGUkeusdyCby',
    ),
    RecipeModel(
      id: '13',
      name: 'Traditional Spare Ribs Baked',
      image: 'assets/images/Traditional spare.jpeg',
      rating: 4.0,
      time: '60 mins',
      author: 'Chef John',
      authorImage: 'assets/images/Traditional spare.jpeg',
      category: 'Asian',
      isSaved: false,
      videoUrl: 'https://youtube.com/shorts/6MX-Wa6uVBs?si=f6mpJqmqwM-Y9qOP',
    ),
    RecipeModel(
      id: '14',
      name: 'Lamb Chops with Fruity Couscous',
      image: 'assets/images/Lamb_chops.jpeg',
      rating: 4.0,
      time: '45 mins',
      author: 'Spicy Nelly',
      authorImage: 'assets/images/Lamb_chops.jpeg',
      category: 'Italian',
      isSaved: false,
      videoUrl: 'https://youtube.com/shorts/bwCVyaXrYTI?si=_ya_67NK1tK7UPPP',
    ),
    RecipeModel(
      id: '15',
      name: 'Chinese Style Egg Fried Rice with Sliced',
      image: 'assets/images/Chinese_style_Egg_fried_rice.jpeg',
      rating: 4.0,
      time: '25 mins',
      author: 'Laura Wilson',
      authorImage: 'assets/images/Chinese_style_Egg_fried_rice.jpeg',
      category: 'Chinese',
      isSaved: false,
      videoUrl: 'https://youtube.com/shorts/ZjEL_bLSRlY?si=ligzEaIU4Rq1DqOd',
    ),
  ];

  // ── getters ───────────────────────────────────────────────────────────────
  UserModel get user => _user;
  int get selectedCategory => _selectedCategory;
  String get searchQuery => _searchQuery;
  String get selectedCategoryName => categories[_selectedCategory];
  List<RecipeModel> get featured => _applyFilters(_featured);
  List<RecipeModel> get newRecipes => _applyFilters(_newRecipes);
  List<VideoModel> get userVideos => _userVideos;

  List<RecipeModel> get allRecipes => [..._featured, ..._newRecipes];

  List<RecipeModel> get searchResults {
    final q = _searchQuery.trim().toLowerCase();
    if (q.isEmpty) return const [];
    return _applyFilters(allRecipes)
        .where((r) => r.name.toLowerCase().contains(q))
        .toList();
  }

  // ── actions ───────────────────────────────────────────────────────────────
  void selectCategory(int index) {
    _selectedCategory = index;
    notifyListeners();
  }

  void updateSearch(String value) {
    _searchQuery = value;
    notifyListeners();
  }

  void updateSearchQuery(String value) {
    _searchQuery = value;
    notifyListeners();
  }

  List<RecipeModel> _applyFilters(List<RecipeModel> list) {
    final selected = selectedCategoryName;
    if (selected == 'All') return list;
    return list.where((r) => r.category == selected).toList();
  }

  void toggleSave(String recipeId) {
    RecipeModel? recipe;

    final fIdx = _featured.indexWhere((r) => r.id == recipeId);
    if (fIdx != -1) {
      final newSaved = !(_savedViewModel?.isSaved(recipeId) ?? _featured[fIdx].isSaved);
      _featured[fIdx] = _featured[fIdx].copyWith(isSaved: newSaved);
      recipe = _featured[fIdx];
    }

    final nIdx = _newRecipes.indexWhere((r) => r.id == recipeId);
    if (nIdx != -1) {
      final newSaved = !(_savedViewModel?.isSaved(recipeId) ?? _newRecipes[nIdx].isSaved);
      _newRecipes[nIdx] = _newRecipes[nIdx].copyWith(isSaved: newSaved);
      recipe = _newRecipes[nIdx];
    }

    if (recipe != null && _savedViewModel != null) {
      if (_savedViewModel!.isSaved(recipeId)) {
        _savedViewModel!.removeRecipe(recipeId);
      } else {
        _savedViewModel!.addRecipe(recipe);
      }
    }

    notifyListeners();
  }

  void addRecipe(RecipeModel recipe) {
    _newRecipes.insert(0, recipe);
    notifyListeners();
  }

  void addVideo(VideoModel video) {
    _userVideos.insert(0, video);
    notifyListeners();
  }

  void deleteVideo(String videoId) {
    final idx = _userVideos.indexWhere((v) => v.id == videoId);
    if (idx != -1) {
      _lastDeletedVideo = _userVideos[idx];
      _lastDeletedVideoIndex = idx;
      _userVideos.removeAt(idx);
      notifyListeners();
    }
  }

  VideoModel? _lastDeletedVideo;
  int? _lastDeletedVideoIndex;

  void undoDeleteVideo() {
    if (_lastDeletedVideo != null && _lastDeletedVideoIndex != null) {
      _userVideos.insert(_lastDeletedVideoIndex!, _lastDeletedVideo!);
      _lastDeletedVideo = null;
      _lastDeletedVideoIndex = null;
      notifyListeners();
    }
  }

  void updateVideo(VideoModel video) {
    final idx = _userVideos.indexWhere((v) => v.id == video.id);
    if (idx != -1) {
      _userVideos[idx] = video;
      notifyListeners();
    }
  }

  RecipeModel? _lastDeletedRecipe;
  int? _lastDeletedIndex;
  bool _lastFromFeatured = false;

  List<RecipeModel> get userRecipes {
    // Return only recipes authored by the current user
    return allRecipes.where((r) => r.author.contains(_user.name)).toList();
  }

  void deleteRecipe(String recipeId) {
    // Find where it was to support undo
    final fIdx = _featured.indexWhere((r) => r.id == recipeId);
    if (fIdx != -1) {
      _lastDeletedRecipe = _featured[fIdx];
      _lastDeletedIndex = fIdx;
      _lastFromFeatured = true;
      _featured.removeAt(fIdx);
    } else {
      final nIdx = _newRecipes.indexWhere((r) => r.id == recipeId);
      if (nIdx != -1) {
        _lastDeletedRecipe = _newRecipes[nIdx];
        _lastDeletedIndex = nIdx;
        _lastFromFeatured = false;
        _newRecipes.removeAt(nIdx);
      }
    }

    if (_savedViewModel != null) {
      _savedViewModel!.removeRecipe(recipeId);
    }
    notifyListeners();
  }

  void undoDelete() {
    if (_lastDeletedRecipe == null) return;
    if (_lastFromFeatured) {
      _featured.insert(_lastDeletedIndex!, _lastDeletedRecipe!);
    } else {
      _newRecipes.insert(_lastDeletedIndex!, _lastDeletedRecipe!);
    }
    _lastDeletedRecipe = null;
    notifyListeners();
  }


  void updateRecipeRating(String recipeId, double newRating) {
    final fIdx = _featured.indexWhere((r) => r.id == recipeId);
    if (fIdx != -1) {
      _featured[fIdx] = _featured[fIdx].copyWithRating(newRating);
    }
    final nIdx = _newRecipes.indexWhere((r) => r.id == recipeId);
    if (nIdx != -1) {
      _newRecipes[nIdx] = _newRecipes[nIdx].copyWithRating(newRating);
    }
    notifyListeners();
  }

  void updateRecipe(RecipeModel recipe) {
    final fIdx = _featured.indexWhere((r) => r.id == recipe.id);
    if (fIdx != -1) {
      _featured[fIdx] = recipe;
    }
    final nIdx = _newRecipes.indexWhere((r) => r.id == recipe.id);
    if (nIdx != -1) {
      _newRecipes[nIdx] = recipe;
    }
    notifyListeners();
  }

  void setUser(UserModel user) {
    _user = user;
    notifyListeners();
  }
}
