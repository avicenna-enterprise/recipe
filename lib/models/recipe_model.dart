import 'ingredient_model.dart';

class RecipeModel {
  final String id;
  final String name;
  final String image;
  final double rating;
  final String time;
  final String author;
  final String authorImage;
  final String category;
  bool isSaved;
  /// Shown as "(13k Reviews)" on detail.
  final int reviewCount;
  final String authorLocation;
  final List<IngredientModel>? ingredients;
  final List<String>? procedures;

  RecipeModel({
    required this.id,
    required this.name,
    required this.image,
    required this.rating,
    required this.time,
    required this.author,
    required this.authorImage,
    required this.category,
    this.isSaved = false,
    this.reviewCount = 13000,
    this.authorLocation = 'Lagos, Nigeria',
    this.ingredients,
    this.procedures,
  });

  RecipeModel copyWith({
    bool? isSaved,
    int? reviewCount,
    String? authorLocation,
  }) {
    return RecipeModel(
      id: id,
      name: name,
      image: image,
      rating: rating,
      time: time,
      author: author,
      authorImage: authorImage,
      category: category,
      isSaved: isSaved ?? this.isSaved,
      reviewCount: reviewCount ?? this.reviewCount,
      authorLocation: authorLocation ?? this.authorLocation,
      ingredients: ingredients,
      procedures: procedures,
    );
  }

  RecipeModel copyWithRating(double newRating) {
    return RecipeModel(
      id: id,
      name: name,
      image: image,
      rating: newRating,
      time: time,
      author: author,
      authorImage: authorImage,
      category: category,
      isSaved: isSaved,
      reviewCount: reviewCount + 1,
      authorLocation: authorLocation,
      ingredients: ingredients,
      procedures: procedures,
    );
  }
}