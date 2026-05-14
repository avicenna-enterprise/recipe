enum NotificationType { newRecipe, savedRecipe, videoWatch }

class NotificationModel {
  final String id;
  final NotificationType type;
  final String title;
  final String message;
  final String timeAgo;
  String dateGroup; // mutable — updates when day changes
  final DateTime createdAt;
  bool isRead;
  final String? recipeId;

  NotificationModel({
    required this.id,
    required this.type,
    required this.title,
    required this.message,
    required this.timeAgo,
    required this.dateGroup,
    required this.createdAt,
    this.isRead = false,
    this.recipeId,
  });
}
