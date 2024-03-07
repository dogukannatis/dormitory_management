import 'package:dormitory_management/ui/widgets/custom_app_bar.dart';
import 'package:dormitory_management/ui/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';

class DormitoriesPage extends StatefulWidget {
  const DormitoriesPage({super.key});

  @override
  State<DormitoriesPage> createState() => _DormitoriesPageState();
}

class _DormitoriesPageState extends State<DormitoriesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: getCustomAppBar(context),
      drawer: const CustomDrawer(),
      body: const Center(
        child: Text("Dormitories"),
      ),
    );
  }
}
