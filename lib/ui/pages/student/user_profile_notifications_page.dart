import 'package:dormitory_management/models/app_notification.dart';
import 'package:dormitory_management/ui/widgets/custom_app_bar.dart';
import 'package:dormitory_management/ui/widgets/custom_drawer.dart';
import 'package:dormitory_management/viewmodels/notification_manager.dart';
import 'package:dormitory_management/viewmodels/user_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timeago/timeago.dart' as timeago;

class UserProfileNotifications extends ConsumerStatefulWidget {
  const UserProfileNotifications({super.key});

  @override
  ConsumerState createState() => _UserProfileNotificationsState();
}

class _UserProfileNotificationsState extends ConsumerState<UserProfileNotifications> {
  List<AppNotification> notifications = [];


  bool isLoading = false;

  Future<void> getNotifications() async {
    final notificationManager = ref.read(notificationManagerProvider.notifier);
    final user = ref.read(userManagerProvider);
    setState(() {
      isLoading = true;
    });
    notifications = await notificationManager.getAllNotificationsByStudentId(studentId: user!.userId!);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getNotifications();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getCustomAppBar(context),
      body: isLoading
          ? const Center(child: CircularProgressIndicator(),)
          : Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomDrawer(activePage: ActivePages.profileNotifications,),
          Expanded(
            child: Padding(
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
                                margin: EdgeInsets.symmetric(vertical: 8),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 2,
                                child: ListTile(
                                  leading: Icon(Icons.notifications, color: Colors.blue),
                                  title: Text(
                                    notification.title!,
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(notification.description!),
                                  trailing: Text(timeago.format(notification.createdAt!)),
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
          ),
        ],
      ),
    );
  }
}









/*

import 'package:dormitory_management/models/app_notification.dart';
import 'package:dormitory_management/ui/widgets/custom_app_bar.dart';
import 'package:dormitory_management/ui/widgets/custom_drawer.dart';
import 'package:dormitory_management/viewmodels/notification_manager.dart';
import 'package:dormitory_management/viewmodels/user_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timeago/timeago.dart' as timeago;

class UserProfileNotifications extends ConsumerStatefulWidget {
  const UserProfileNotifications({super.key});

  @override
  ConsumerState createState() => _UserProfileNotificationsState();
}

class _UserProfileNotificationsState extends ConsumerState<UserProfileNotifications> {
  List<AppNotification> notifications = [];


  bool isLoading = false;

  Future<void> getNotifications() async {
    final notificationManager = ref.read(notificationManagerProvider.notifier);
    final user = ref.read(userManagerProvider);
    setState(() {
      isLoading = true;
    });
    notifications = await notificationManager.getAllNotificationsByStudentId(studentId: user!.userId!);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getNotifications();
    super.initState();
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getCustomAppBar(context),
      drawer: const CustomDrawer(),
      body: isLoading ? const Center(child: CircularProgressIndicator(),) : Padding(
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
                          margin: EdgeInsets.symmetric(vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 2,
                          child: ListTile(
                            leading: Icon(Icons.notifications, color: Colors.blue),
                            title: Text(
                              notification.title!,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(notification.description!),
                            trailing: Text(timeago.format(notification.createdAt!)),
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

*/