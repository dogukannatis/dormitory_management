import 'package:dormitory_management/models/app_notification.dart';
import 'package:dormitory_management/models/booking.dart';
import 'package:dormitory_management/models/users/dormitory_owner.dart';
import 'package:dormitory_management/ui/widgets/custom_app_bar.dart';
import 'package:dormitory_management/ui/widgets/custom_drawer.dart';
import 'package:dormitory_management/viewmodels/booking_manager.dart';
import 'package:dormitory_management/viewmodels/user_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DormMGBookingHistory extends ConsumerStatefulWidget {
  const DormMGBookingHistory({super.key});

  @override
  ConsumerState createState() => _DormMGBookingHistoryState();
}

class _DormMGBookingHistoryState extends ConsumerState<DormMGBookingHistory> {
  List<Booking> bookings = [];

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
      case 'Decline':
      default:
        color = Colors.red;
        label = 'Declined';
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
        label,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Future<void> approveBooking(int bookingId) async {
    final bookingManager = ref.read(bookingManagerProvider.notifier);
    int i = bookings.indexWhere((element) => (element.bookingId == bookingId));
    setState(() {
      bookings[i].status = "Approved";
    });

    await bookingManager.approveStudentsBookingRequest(bookingId: bookingId);
  }

  Future<void> deleteBooking(int bookingId) async {
    final bookingManager = ref.read(bookingManagerProvider.notifier);
    setState(() {
      bookings.removeWhere((element) => element.bookingId == bookingId);
    });
    await bookingManager.deleteBookingByID(bookingId: bookingId);
  }


  Widget _buildActionButton(int bookingId) {
    return PopupMenuButton<int>(
      itemBuilder: (context) => [
        PopupMenuItem<int>(
            value: 0,
            child: const Text('Approve'),
            onTap: (){
              approveBooking(bookingId);
            }
        ),
        PopupMenuItem<int>(
            value: 1,
            child: const Text('Delete'),
            onTap: (){
              deleteBooking(bookingId);
            }
        ),
      ],
    );
  }

  @override
  void initState() {
    getBookings();
    super.initState();
  }

  bool isLoading = false;


  Future<void> getBookings() async {
    final bookingManager = ref.read(bookingManagerProvider.notifier);
    final user = ref.read(userManagerProvider);
    setState(() {
      isLoading = true;
    });
    bookings = await bookingManager.getBookingsByDormitoryId(dormitoryId: (user as DormitoryOwner).dormitoryId!);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getCustomAppBar(context),
      body: Row(
        children: [
          CustomDrawer(activePage: ActivePages.dormMGbookingHistory,),
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
                                columns: [
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
                                    DataCell(Text('${booking.user?.name} ${booking.user?.surName}')),
                                    DataCell(_buildStatusChip(booking.status ?? 'Unknown')),
                                    DataCell(Text('${booking.room?.roomType}')),
                                    DataCell(Text('23-24 / F-S')),
                                    DataCell(Text("${booking.user?.phoneNo}")),
                                    DataCell(Text('${booking.room?.price}')),
                                    DataCell(_buildActionButton(booking.bookingId!)),
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
