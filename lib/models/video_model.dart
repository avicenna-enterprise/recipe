class VideoModel {
  final String id;
  final String title;
  final String thumbnail;
  final String videoUrl;
  final String author;
  final String views;
  final String duration;
  final DateTime createdAt;

  VideoModel({
    required this.id,
    required this.title,
    required this.thumbnail,
    required this.videoUrl,
    required this.author,
    required this.views,
    required this.duration,
    required this.createdAt,
  });
}
