import 'package:dormitory_management/ui/widgets/custom_app_bar.dart';
import 'package:dormitory_management/ui/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';

class AdminManageDorm extends StatefulWidget {
  const AdminManageDorm({super.key});

  @override
  State<AdminManageDorm> createState() => _AdminManageDormState();
}

class _AdminManageDormState extends State<AdminManageDorm> {
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