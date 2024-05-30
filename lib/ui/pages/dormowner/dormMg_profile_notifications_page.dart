import 'package:dormitory_management/models/app_notification.dart';
import 'package:dormitory_management/ui/widgets/custom_app_bar.dart';
import 'package:dormitory_management/ui/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserProfileNotifications extends ConsumerStatefulWidget {
  const UserProfileNotifications({super.key});

  @override
  ConsumerState createState() => _UserProfileNotificationsState();
}

class _UserProfileNotificationsState extends ConsumerState<UserProfileNotifications> {
  List<AppNotification> notifications = [
    AppNotification(
      id: 1,
      title: "Dormitory Status Update",
      description: "Your dormitory status changed to Approved.",
      senderId: 1,
      receiverId: 1,
      seen: false,
      createdAt: DateTime.now(),
    ),
    AppNotification(
      id: 2,
      title: "Dormitory Status Update",
      description: "Your dormitory status changed to Pending.",
      senderId: 1,
      receiverId: 1,
      seen: false,
      createdAt: DateTime.now().subtract(const Duration(hours: 12)),
    ),
    AppNotification(
      id: 3,
      title: "You Got a Message!",
      description: "You have an unread message!",
      senderId: 1,
      receiverId: 1,
      seen: false,
      createdAt: DateTime.now().subtract(const Duration(hours: 10)),
    ),
  ];

  String _formatDateTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hours ago';
    } else {
      final days = difference.inDays;
      if (days == 1) {
        return 'Yesterday';
      } else if (days < 7) {
        return '$days days ago';
      } else {
        final weeks = (days / 7).floor();
        return '$weeks week${weeks > 1 ? 's' : ''} ago';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getCustomAppBar(context),
      drawer: const CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Align(
          alignment: Alignment.topLeft,
          child: Card(
            color: Colors.white,
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Container(
              padding: const EdgeInsets.all(24.0),
              constraints: const BoxConstraints(maxWidth: 1000),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Notifications',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      itemCount: notifications.length,
                      itemBuilder: (context, index) {
                        final notification = notifications[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 2,
                          child: ListTile(
                            leading: const Icon(Icons.notifications, color: Colors.blue),
                            title: Text(
                              notification.title!,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(notification.description!),
                            trailing: Text(_formatDateTime(notification.createdAt!)),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
