import 'package:flutter/material.dart';
import '../models/notification_model.dart';

enum NotificationFilter { all, read, unread }

class NotificationViewModel extends ChangeNotifier {
  NotificationFilter _filter = NotificationFilter.all;
  NotificationFilter get filter => _filter;

  final List<NotificationModel> _notifications = [];

  // ── Real event triggers ───────────────────────────────────────────────

  void onRecipeSaved(String recipeName) {
    _add(NotificationModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      type: NotificationType.savedRecipe,
      title: 'Recipe Saved!',
      message: '"$recipeName" has been added to your saved recipes.',
      timeAgo: 'Just now',
      dateGroup: _dateGroup(DateTime.now()),
      createdAt: DateTime.now(),
      isRead: false,
    ));
  }

  void onNewRecipeAdded(String recipeName) {
    _add(NotificationModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      type: NotificationType.newRecipe,
      title: 'New Recipe Alert!',
      message: 'A new recipe "$recipeName" has been added. Check it out!',
      timeAgo: 'Just now',
      dateGroup: _dateGroup(DateTime.now()),
      createdAt: DateTime.now(),
      isRead: false,
    ));
  }

  void onVideoWatched(String recipeName) {
    _add(NotificationModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      type: NotificationType.videoWatch,
      title: 'Video Watch Alert!',
      message: 'Someone just watched your "$recipeName" recipe video!',
      timeAgo: 'Just now',
      dateGroup: _dateGroup(DateTime.now()),
      createdAt: DateTime.now(),
      isRead: false,
    ));
  }

  // ── Date group helper ─────────────────────────────────────────────────
  String _dateGroup(DateTime dt) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final notifDay = DateTime(dt.year, dt.month, dt.day);
    final diff = today.difference(notifDay).inDays;
    if (diff == 0) return 'Today';
    if (diff == 1) return 'Yesterday';
    return '${dt.day}/${dt.month}/${dt.year}';
  }

  // ── Refresh date groups (call on app resume) ──────────────────────────
  void refreshDateGroups() {
    for (var n in _notifications) {
      n.dateGroup = _dateGroup(n.createdAt);
    }
    notifyListeners();
  }

  // ── Getters ───────────────────────────────────────────────────────────

  List<NotificationModel> get notifications {
    switch (_filter) {
      case NotificationFilter.read:
        return _notifications.where((n) => n.isRead).toList();
      case NotificationFilter.unread:
        return _notifications.where((n) => !n.isRead).toList();
      case NotificationFilter.all:
        return _notifications;
    }
  }

  List<String> get dateGroups =>
      notifications.map((n) => n.dateGroup).toSet().toList();

  List<NotificationModel> getByGroup(String group) =>
      notifications.where((n) => n.dateGroup == group).toList();

  int get unreadCount =>
      _notifications.where((n) => !n.isRead).length;

  // ── Actions ───────────────────────────────────────────────────────────

  void setFilter(NotificationFilter f) {
    _filter = f;
    notifyListeners();
  }

  void markAsRead(String id) {
    final idx = _notifications.indexWhere((n) => n.id == id);
    if (idx != -1) {
      _notifications[idx].isRead = true;
      notifyListeners();
    }
  }

  void markAllRead() {
    for (var n in _notifications) {
      n.isRead = true;
    }
    notifyListeners();
  }

  // Last deleted notification for undo
  NotificationModel? _lastDeleted;
  int? _lastDeletedIndex;

  void deleteNotification(String id) {
    final idx = _notifications.indexWhere((n) => n.id == id);
    if (idx != -1) {
      _lastDeleted = _notifications[idx];
      _lastDeletedIndex = idx;
      _notifications.removeAt(idx);
      notifyListeners();
    }
  }

  void undoDelete() {
    if (_lastDeleted != null && _lastDeletedIndex != null) {
      final insertIdx = _lastDeletedIndex!.clamp(0, _notifications.length);
      _notifications.insert(insertIdx, _lastDeleted!);
      _lastDeleted = null;
      _lastDeletedIndex = null;
      notifyListeners();
    }
  }

  void deleteAll() {
    _notifications.clear();
    _lastDeleted = null;
    _lastDeletedIndex = null;
    notifyListeners();
  }

  void _add(NotificationModel n) {
    _notifications.insert(0, n);
    notifyListeners();
  }
}
