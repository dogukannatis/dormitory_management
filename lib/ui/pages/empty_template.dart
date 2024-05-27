import 'package:dormitory_management/ui/widgets/custom_app_bar.dart';
import 'package:dormitory_management/ui/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';

class DormOccupancyRates extends StatefulWidget {
  const DormOccupancyRates({super.key});

  @override
  State<DormOccupancyRates> createState() => _DormOccupancyRatesState();
}

class _DormOccupancyRatesState extends State<DormOccupancyRates> {
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