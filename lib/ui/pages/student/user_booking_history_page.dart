import 'package:dormitory_management/models/booking.dart';
import 'package:dormitory_management/ui/widgets/custom_app_bar.dart';
import 'package:dormitory_management/ui/widgets/custom_drawer.dart';
import 'package:dormitory_management/viewmodels/booking_manager.dart';
import 'package:dormitory_management/viewmodels/user_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserBookingHistory extends ConsumerStatefulWidget {
  const UserBookingHistory({super.key});

  @override
  ConsumerState createState() => _UserBookingHistoryState();
}

class _UserBookingHistoryState extends ConsumerState<UserBookingHistory> {


  List<Booking> bookings = [];
  bool isLoading = false;

  Future<void> getAllBookingHistory() async {
    final bookingManager = ref.read(bookingManagerProvider.notifier);
    final user = ref.read(userManagerProvider);
    setState(() {
      isLoading = true;
    });
    bookings = await bookingManager.getBookingHistoryByStudentId(userId: user!.userId!);
    setState(() {
      isLoading = false;
    });
  }
  @override
  void initState() {
    getAllBookingHistory();
    super.initState();
  }



  Widget _buildStatusChip(String status) {
    Color color;
    String label;

    switch (status) {
      case 'Approved':
        color = Colors.green;
        label = 'Approved';
        break;
      case 'Pending':
        color = Colors.orange;
        label = 'Pending';
        break;
      case 'Former':
      default:
        color = Colors.red;
        label = 'Former';
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
      body: isLoading
          ? Center(
        child: CircularProgressIndicator(),
      )
          : Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomDrawer(activePage: ActivePages.userBookingHistory,),
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
                    constraints: BoxConstraints(maxWidth: 1000),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Booking History',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 20),
                        Expanded(
                          child: ListView(
                            children: [
                              DataTable(
                                columnSpacing: 12.0,
                                columns: const [
                                  DataColumn(label: Text('Dormitory')),
                                  DataColumn(label: Text('Status')),
                                  DataColumn(label: Text('Room ID')),
                                  DataColumn(label: Text('Year & Term')),
                                  DataColumn(label: Text('Contact')),
                                  //DataColumn(label: Text('Price TRY')),
                                  //DataColumn(label: Text('Action')),
                                ],
                                rows: bookings.map((booking) {
                                  return DataRow(cells: [
                                    DataCell(Text('${booking.dormitory?.name}')),
                                    DataCell(_buildStatusChip(booking.status ?? 'Unknown')),
                                    //DataCell(Text('${booking.room?.roomType}')),
                                    DataCell(Text('${booking.roomId}')),
                                    const DataCell(Text('23-24 / F-S')), // Bu veri modelde yok, şimdilik manuel ekliyoruz
                                    DataCell(Text("${booking.dormitory?.dormitoryDetails?.email}")),
                                    // DataCell(Text('TRY 75000.00')), // Bu veri modelde yok, şimdilik manuel ekliyoruz
                                    //DataCell(_buildActionButton()),
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








/*

import 'package:dormitory_management/models/booking.dart';
import 'package:dormitory_management/ui/widgets/custom_app_bar.dart';
import 'package:dormitory_management/ui/widgets/custom_drawer.dart';
import 'package:dormitory_management/viewmodels/booking_manager.dart';
import 'package:dormitory_management/viewmodels/user_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserBookingHistory extends ConsumerStatefulWidget {
  const UserBookingHistory({super.key});

  @override
  ConsumerState createState() => _UserBookingHistoryState();
}

class _UserBookingHistoryState extends ConsumerState<UserBookingHistory> {


  List<Booking> bookings = [];
  bool isLoading = false;

  Future<void> getAllBookingHistory() async {
    final bookingManager = ref.read(bookingManagerProvider.notifier);
    final user = ref.read(userManagerProvider);
    setState(() {
      isLoading = true;
    });
    bookings = await bookingManager.getBookingHistoryByStudentId(userId: user!.userId!);
    setState(() {
      isLoading = false;
    });
  }
  @override
  void initState() {
    getAllBookingHistory();
    super.initState();
  }



  Widget _buildStatusChip(String status) {
    Color color;
    String label;

    switch (status) {
      case 'Current':
        color = Colors.green;
        label = 'Current';
        break;
      case 'In Debt':
        color = Colors.orange;
        label = 'In Debt';
        break;
      case 'Former':
      default:
        color = Colors.red;
        label = 'Former';
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
      body: isLoading ? Center(
        child: CircularProgressIndicator(),
      ) : Padding(
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
                    'Booking History',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: ListView(
                      children: [
                        DataTable(
                          columnSpacing: 12.0,
                          columns: const [
                            DataColumn(label: Text('Dormitory')),
                            DataColumn(label: Text('Status')),
                            DataColumn(label: Text('Room')),
                            DataColumn(label: Text('Year & Term')),
                            DataColumn(label: Text('Contact')),
                            //DataColumn(label: Text('Price TRY')),
                           // DataColumn(label: Text('Action')),
                          ],
                          rows: bookings.map((booking) {
                            return DataRow(cells: [
                              DataCell(Text('${booking.dormitory?.name}')),
                              DataCell(_buildStatusChip(booking.status ?? 'Unknown')),
                              DataCell(Text('Room ${booking.roomId}')),
                              const DataCell(Text('23-24 / F-S')), // Bu veri modelde yok, şimdilik manuel ekliyoruz
                              DataCell(Text("${booking.dormitory?.dormitoryDetails?.email}")), // Bu veri modelde yok, şimdilik manuel ekliyoruz
                             // DataCell(Text('TRY 75000.00')), // Bu veri modelde yok, şimdilik manuel ekliyoruz
                              //DataCell(_buildActionButton()),
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

*/