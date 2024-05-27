import 'package:dormitory_management/ui/widgets/custom_app_bar.dart';
import 'package:dormitory_management/ui/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';

class DormMGEditDorm extends StatefulWidget {
  const DormMGEditDorm({super.key});

  @override
  State<DormMGEditDorm> createState() => _DormMGEditDormState();
}

class _DormMGEditDormState extends State<DormMGEditDorm> {
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