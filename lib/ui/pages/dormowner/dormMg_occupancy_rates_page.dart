import 'package:dormitory_management/models/dormitory_details.dart';
import 'package:dormitory_management/ui/widgets/custom_app_bar.dart';
import 'package:dormitory_management/ui/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DormOccupancyRates extends ConsumerStatefulWidget {
  const DormOccupancyRates({super.key});

  @override
  ConsumerState createState() => _DormOccupancyRatesState();
}

class _DormOccupancyRatesState extends ConsumerState<DormOccupancyRates> {
  List<DormitoryDetails> dormitories = [
    DormitoryDetails(
      detailId: 1,
      dormitoryId: 1,
      contactNo: "+90 555 555 55 55",
      capacity: 1000,
      description: "Running",
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    DormitoryDetails(
      detailId: 2,
      dormitoryId: 2,
      contactNo: "+90 444 444 44 44",
      capacity: 1000,
      description: "Running",
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    DormitoryDetails(
      detailId: 3,
      dormitoryId: 3,
      contactNo: "+90 333 333 33 33",
      capacity: 650,
      description: "Renovation",
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    DormitoryDetails(
      detailId: 4,
      dormitoryId: 4,
      contactNo: "+90 222 222 22 22",
      capacity: 1500,
      description: "Running",
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    DormitoryDetails(
      detailId: 5,
      dormitoryId: 5,
      contactNo: "+90 111 111 11 11",
      capacity: 300,
      description: "Closed",
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
  ];

  Widget _buildStatusChip(String status) {
    Color color;
    switch (status) {
      case 'Running':
        color = Colors.green;
        break;
      case 'Renovation':
        color = Colors.orange;
        break;
      case 'Closed':
      default:
        color = Colors.red;
        break;
    }

    return Container(
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color),
      ),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Text(
        status,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildActionButton() {
    return PopupMenuButton<int>(
      onSelected: (item) => print('Selected item: $item'),
      itemBuilder: (context) => [
        PopupMenuItem<int>(value: 0, child: Text('Action 1')),
        PopupMenuItem<int>(value: 1, child: Text('Action 2')),
      ],
    );
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
              constraints: BoxConstraints(maxWidth: 1000),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Dorm Occupancy Rates',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: ListView(
                      children: [
                        DataTable(
                          columnSpacing: 12.0,
                          columns: [
                            DataColumn(label: Text('Dormitories')),
                            DataColumn(label: Text('Status')),
                            DataColumn(label: Text('Capacity')),
                            DataColumn(label: Text('Occupancy Rate')),
                            DataColumn(label: Text('Manager Contact')),
                            DataColumn(label: Text('Action')),
                          ],
                          rows: dormitories.map((dormitory) {
                            return DataRow(cells: [
                              DataCell(Text('UniVerse ${dormitory.dormitoryId}')),
                              DataCell(_buildStatusChip(dormitory.description ?? 'Unknown')),
                              DataCell(Text('${dormitory.capacity}')),
                              DataCell(Text(dormitory.description == 'Running' ? '90%' : '0%')),
                              DataCell(Text(dormitory.contactNo ?? 'N/A')),
                              DataCell(_buildActionButton()),
                            ]);
                          }).toList(),
                        ),
                      ],
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
