import 'package:flutter/material.dart';
import '../models/comment_model.dart';

class ReviewsViewModel extends ChangeNotifier {
  // Store comments per recipe ID
  final Map<String, List<CommentModel>> _commentsMap = {};

  List<CommentModel> getCommentsForRecipe(String recipeId) {
    return _commentsMap[recipeId] ?? [];
  }

  void addComment(String recipeId, String text, {double? rating}) {
    if (text.trim().isEmpty) return;
    
    if (!_commentsMap.containsKey(recipeId)) {
      _commentsMap[recipeId] = [];
    }

    _commentsMap[recipeId]!.insert(0, CommentModel(
      id: DateTime.now().toString(),
      userName: 'You',
      userImage: 'assets/user_placeholder.png',
      date: 'Just now',
      text: text.trim(),
    ));
    
    notifyListeners();
  }

  void likeComment(String recipeId, String commentId) {
    final comments = _commentsMap[recipeId];
    if (comments == null) return;
    final index = comments.indexWhere((c) => c.id == commentId);
    if (index != -1) {
      comments[index].likes++;
      notifyListeners();
    }
  }

  void dislikeComment(String recipeId, String commentId) {
    final comments = _commentsMap[recipeId];
    if (comments == null) return;
    final index = comments.indexWhere((c) => c.id == commentId);
    if (index != -1) {
      comments[index].dislikes++;
      notifyListeners();
    }
  }
}
