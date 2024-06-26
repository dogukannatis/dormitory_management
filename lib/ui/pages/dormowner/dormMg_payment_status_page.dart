import 'package:dormitory_management/models/booking.dart';
import 'package:dormitory_management/ui/widgets/custom_app_bar.dart';
import 'package:dormitory_management/ui/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DormMGPaymentStatus extends ConsumerStatefulWidget {
  const DormMGPaymentStatus({super.key});

  @override
  ConsumerState createState() => _DormMGPaymentStatusState();
}

class _DormMGPaymentStatusState extends ConsumerState<DormMGPaymentStatus> {
  List<Booking> bookings = [
    Booking(bookingId: 1, userId: 1, dormitoryId: 1, roomId: 3, status: "Current"),
    Booking(bookingId: 2, userId: 1, dormitoryId: 2, roomId: 3, status: "Former"),
    Booking(bookingId: 3, userId: 1, dormitoryId: 3, roomId: 3, status: "In Debt"),
    Booking(bookingId: 4, userId: 1, dormitoryId: 4, roomId: 3, status: "Current"),
    Booking(bookingId: 5, userId: 1, dormitoryId: 5, roomId: 3, status: "Current"),
  ];

  Widget _buildStatusChip(String status) {
    Color color;
    String label;

    switch (status) {
      case 'Current':
        color = Colors.green;
        label = 'Paid';
        break;
      case 'In Debt':
        color = Colors.orange;
        label = 'In Progress';
        break;
      case 'Former':
      default:
        color = Colors.red;
        label = 'Not Paid';
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
        label,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildActionButton() {
    return PopupMenuButton<int>(
      onSelected: (item) => debugPrint('Selected item: $item'),
      itemBuilder: (context) => const [
        PopupMenuItem<int>(value: 0, child: Text('Action 1')),
        PopupMenuItem<int>(value: 1, child: Text('Action 2')),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getCustomAppBar(context),
      body: Row(
        children: [
          const CustomDrawer(activePage: ActivePages.dormMGpaymentStatus,),
          Expanded(
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
                    constraints: const BoxConstraints(maxWidth: 1000),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Payment Status',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 20),
                        Expanded(
                          child: ListView(
                            children: [
                              DataTable(
                                columnSpacing: 12.0,
                                columns: const [
                                  DataColumn(label: Text('User')),
                                  DataColumn(label: Text('Status')),
                                  DataColumn(label: Text('Room')),
                                  DataColumn(label: Text('SKU')),
                                  DataColumn(label: Text('Contact')),
                                  DataColumn(label: Text('Price TRY')),
                                  DataColumn(label: Text('Action')),
                                ],
                                rows: bookings.map((booking) {
                                  return DataRow(cells: [
                                    DataCell(Text('Universe ${booking.dormitoryId}')),
                                    DataCell(_buildStatusChip(booking.status ?? 'Unknown')),
                                    DataCell(Text('Room ${booking.roomId}')),
                                    const DataCell(Text('23-24 / F-S')), // Bu veri modelde yok, şimdilik manuel ekliyoruz
                                    const DataCell(Text('+90 555 555 55 55')), // Bu veri modelde yok, şimdilik manuel ekliyoruz
                                    const DataCell(Text('TRY 75000.00')), // Bu veri modelde yok, şimdilik manuel ekliyoruz
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
          ),
        ],
      ),
    );
  }
}
