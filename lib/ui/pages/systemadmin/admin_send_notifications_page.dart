import 'package:dormitory_management/ui/widgets/custom_app_bar.dart';
import 'package:dormitory_management/ui/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';

class AdminSendNotifications extends StatefulWidget {
  const AdminSendNotifications({super.key});

  @override
  State<AdminSendNotifications> createState() => _AdminSendNotificationsState();
}

class _AdminSendNotificationsState extends State<AdminSendNotifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getCustomAppBar(context),
      drawer: const CustomDrawer(),
      body: const Center(
        child: Text("Dorm Occupancy Rates"),
      ),
    );
  }
}