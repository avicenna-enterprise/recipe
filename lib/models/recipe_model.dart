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
  final String? videoUrl;

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
    this.videoUrl,
  });

  RecipeModel copyWith({
    bool? isSaved,
    int? reviewCount,
    String? authorLocation,
    String? videoUrl,
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
      videoUrl: videoUrl ?? this.videoUrl,
    );
  }
}