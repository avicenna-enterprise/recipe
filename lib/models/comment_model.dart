class CommentModel {
  final String id;
  final String userName;
  final String userImage;
  final String date;
  final String text;
  int likes;
  int dislikes;

  CommentModel({
    required this.id,
    required this.userName,
    required this.userImage,
    required this.date,
    required this.text,
    this.likes = 0,
    this.dislikes = 0,
  });
}
