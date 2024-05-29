import 'package:dormitory_management/models/dormitory.dart';
import 'package:dormitory_management/models/users/dormitory_owner.dart';
import 'package:dormitory_management/ui/widgets/custom_app_bar.dart';
import 'package:dormitory_management/ui/widgets/custom_drawer.dart';
import 'package:dormitory_management/viewmodels/dorm_manager.dart';
import 'package:dormitory_management/viewmodels/user_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DormMGOccupancyRates extends ConsumerStatefulWidget {
  const DormMGOccupancyRates({super.key});

  @override
  ConsumerState createState() => _DormMGOccupancyRatesState();
}

class _DormMGOccupancyRatesState extends ConsumerState<DormMGOccupancyRates> {

  Dormitory? dormitory;
  bool isLoading = false;


  @override
  void initState() {
    getDormitory();
    super.initState();
  }

  Future<void> getDormitory() async {
    final dormManager = ref.read(dormManagerProvider.notifier);
    final user = ref.read(userManagerProvider);
    setState(() {
      isLoading = true;
    });
    dormitory = await dormManager.getDormitoryByID(dormitoryId: (user as DormitoryOwner).dormitoryId!);
    setState(() {
      isLoading = false;
    });
  }

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
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Text(
        status,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getCustomAppBar(context),
      body: Row(
        children: [
          CustomDrawer(activePage: ActivePages.dormMGocuupancyRates,),
          isLoading ? const Expanded(child: Center(child: CircularProgressIndicator(),)) : Expanded(
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
                    constraints: BoxConstraints(maxWidth: 1000),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Dorm Occupancy Rates',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 20),
                        Expanded(
                          child: ListView(
                            children: [
                              DataTable(
                                columnSpacing: 12.0,
                                columns: const [
                                  DataColumn(label: Text('Dormitory Name')),
                                  DataColumn(label: Text('Status')),
                                  DataColumn(label: Text('Capacity')),
                                  DataColumn(label: Text('Quota')),
                                  DataColumn(label: Text('Left')),

                                ],
                                rows: [
                                  DataRow(
                                      cells: [
                                        DataCell(Text('${dormitory!.name}')),
                                        DataCell(_buildStatusChip("Running")),
                                        DataCell(Text('${dormitory!.dormitoryDetails!.capacity}')),
                                        DataCell(Text('${dormitory!.quota}')),
                                        DataCell(Text('${dormitory!.dormitoryDetails!.capacity! - dormitory!.quota!}')),

                                      ]
                                  )
                                ]
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
          ),
        ],
      ),
    );
  }
}

