import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/notification_model.dart';
import '../../viewmodels/notification_viewmodel.dart';
import 'widgets/notification_filter_tab.dart';
import 'widgets/notification_tile.dart';
import 'notification_detail_screen.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Use global NotificationViewModel from main.dart — no new provider
    return const _NotificationsBody();
  }
}

class _NotificationsBody extends StatelessWidget {
  const _NotificationsBody();

  void _confirmDeleteAll(
      BuildContext context, NotificationViewModel vm) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Clear All Notifications'),
        content: const Text(
            'Are you sure you want to delete all notifications?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              vm.deleteAll();
              Navigator.pop(context);
            },
            child: const Text(
              'Delete All',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<NotificationViewModel>();

    return Material(
      color: Colors.white,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header ──────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Notifications',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A1A1A),
                    ),
                  ),
                  // Action buttons
                  Row(
                    children: [
                      if (vm.unreadCount > 0)
                        TextButton(
                          onPressed: vm.markAllRead,
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8),
                            minimumSize: Size.zero,
                          ),
                          child: const Text(
                            'Mark all read',
                            style: TextStyle(
                              color: Color(0xFF1B8A6B),
                              fontSize: 12,
                            ),
                          ),
                        ),
                      if (vm.notifications.isNotEmpty)
                        TextButton(
                          onPressed: () => _confirmDeleteAll(context, vm),
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8),
                            minimumSize: Size.zero,
                          ),
                          child: const Text(
                            'Clear all',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 12,
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),

            // ── Filter Tabs ─────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  NotificationFilterTab(
                    label: 'All',
                    isSelected:
                        vm.filter == NotificationFilter.all,
                    onTap: () =>
                        vm.setFilter(NotificationFilter.all),
                  ),
                  const SizedBox(width: 16),
                  NotificationFilterTab(
                    label: 'Read',
                    isSelected:
                        vm.filter == NotificationFilter.read,
                    onTap: () =>
                        vm.setFilter(NotificationFilter.read),
                  ),
                  const SizedBox(width: 16),
                  NotificationFilterTab(
                    label: 'Unread',
                    isSelected:
                        vm.filter == NotificationFilter.unread,
                    onTap: () =>
                        vm.setFilter(NotificationFilter.unread),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // ── Notification List ────────────────────────────────────
            Expanded(
              child: vm.notifications.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.notifications_none,
                              size: 64, color: Color(0xFF9E9E9E)),
                          SizedBox(height: 16),
                          Text(
                            'No notifications yet',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF1A1A1A)),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Save a recipe or watch a video\nto see notifications here',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 13, color: Color(0xFF9E9E9E)),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: vm.dateGroups.length,
                      itemBuilder: (context, groupIndex) {
                        final group = vm.dateGroups[groupIndex];
                        final items = vm.getByGroup(group);
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Date group header
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 12),
                              child: Text(
                                group,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF1A1A1A),
                                ),
                              ),
                            ),
                            // Notifications in this group
                            ...items.map((notif) => Padding(
                                  padding:
                                      const EdgeInsets.only(bottom: 10),
                                  child: Dismissible(
                                    key: Key(notif.id),
                                    direction: DismissDirection.endToStart,
                                    background: Container(
                                      alignment: Alignment.centerRight,
                                      padding: const EdgeInsets.only(
                                          right: 20),
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius:
                                            BorderRadius.circular(14),
                                      ),
                                      child: const Icon(
                                        Icons.delete_outline,
                                        color: Colors.white,
                                        size: 26,
                                      ),
                                    ),
                                    onDismissed: (_) {
                                      vm.deleteNotification(notif.id);
                                      ScaffoldMessenger.of(context)
                                          .clearSnackBars();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: const Text(
                                              'Notification deleted'),
                                          duration:
                                              const Duration(seconds: 2),
                                          action: SnackBarAction(
                                            label: 'UNDO',
                                            textColor: const Color(
                                                0xFF1B8A6B),
                                            onPressed: () {
                                              vm.undoDelete();
                                            },
                                          ),
                                        ),
                                      );
                                    },
                                    child: NotificationTile(
                                      notification: notif,
                                      onTap: () {
                                        vm.markAsRead(notif.id);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => NotificationDetailScreen(
                                              notification: notif,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                )),
                          ],
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}


