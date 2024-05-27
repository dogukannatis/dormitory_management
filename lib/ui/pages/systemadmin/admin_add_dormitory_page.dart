import 'package:dormitory_management/ui/widgets/custom_app_bar.dart';
import 'package:dormitory_management/ui/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';

class AdminAddDorm extends StatefulWidget {
  const AdminAddDorm({super.key});

  @override
  State<AdminAddDorm> createState() => _AdminAddDormState();
}

class _AdminAddDormState extends State<AdminAddDorm> {
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