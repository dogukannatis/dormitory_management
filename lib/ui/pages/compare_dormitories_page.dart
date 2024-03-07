import 'package:dormitory_management/ui/widgets/custom_app_bar.dart';
import 'package:dormitory_management/ui/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';

class CompareDormitoriesPage extends StatefulWidget {
  const CompareDormitoriesPage({super.key});

  @override
  State<CompareDormitoriesPage> createState() => _CompareDormitoriesPageState();
}

class _CompareDormitoriesPageState extends State<CompareDormitoriesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: getCustomAppBar(context),
      drawer: const CustomDrawer(),
      body: const Center(
        child: Text("Compare Dormitories"),
      ),
    );
  }
}
