import 'package:dormitory_management/ui/widgets/custom_app_bar.dart';
import 'package:dormitory_management/ui/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';

class DormMGSendNotifications extends StatefulWidget {
  const DormMGSendNotifications({super.key});

  @override
  State<DormMGSendNotifications> createState() => _DormMGSendNotificationsState();
}

class _DormMGSendNotificationsState extends State<DormMGSendNotifications> {
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