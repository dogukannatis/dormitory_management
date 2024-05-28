import 'package:dormitory_management/models/users/dormitory_owner.dart';
import 'package:dormitory_management/models/users/student.dart';
import 'package:dormitory_management/ui/pages/dormowner/dormMg_occupancy_rates_page.dart';
import 'package:dormitory_management/ui/pages/student/user_edit_profile_page.dart';
import 'package:dormitory_management/ui/pages/student/user_profile_dormitory.dart';
import 'package:dormitory_management/ui/pages/student/user_booking_history_page.dart';
import 'package:dormitory_management/ui/pages/student/user_profile_notifications_page.dart';
import 'package:dormitory_management/ui/pages/student/user_profile_chat_page.dart';
import 'package:dormitory_management/ui/pages/dormowner/dormMg_set_dateRange_page.dart';
import 'package:dormitory_management/ui/pages/dormowner/dormMg_edit_dormitory_page.dart';
import 'package:dormitory_management/ui/pages/dormowner/dormMg_send_notifications_page.dart';
import 'package:dormitory_management/ui/pages/dormowner/dormMg_manage_room_page.dart';
import 'package:dormitory_management/ui/pages/dormowner/dormMg_payment_status_page.dart';
import 'package:dormitory_management/ui/pages/dormowner/dormMg_booking_history_page.dart';
import 'package:dormitory_management/ui/pages/dormowner/dormMg_reviews_and_ratings_page.dart';
import 'package:dormitory_management/ui/pages/systemadmin/admin_send_notifications_page.dart';
import 'package:dormitory_management/ui/pages/systemadmin/admin_manage_dormitory_page.dart';
import 'package:dormitory_management/ui/pages/systemadmin/admin_add_dormitory_page.dart';
import 'package:dormitory_management/viewmodels/user_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/users/admin.dart';
import '../../models/users/user.dart';

class CustomDrawer extends ConsumerStatefulWidget {
  const CustomDrawer({
    super.key,
  });

  @override
  ConsumerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends ConsumerState<CustomDrawer> {

  @override
  Widget build(BuildContext context) {
    User? user = ref.watch(userManagerProvider);

    if(user is Student){
      return _getStudentDrawer();
    }else if(user is DormitoryOwner){
      return _getStudentDrawer();
    }else if(user is Admin){
      return _getStudentDrawer();
    }else{
      return _getStudentDrawer();
    }

  }

  Widget _getStudentDrawer(){
    return Drawer(
      child: Column(
        children: [
          ListTile(
            onTap: (){
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const EditProfilePage()));
            },
            title: const Text("Edit Profile"),
          ),
          ListTile(
            onTap: (){
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const UserProfileDormitory()));
            },
            title: const Text("My Dormitory"),
          ),
          ListTile(
            onTap: (){
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const UserBookingHistory()));
            },
            title: const Text("Booking History"),
          ),
          ListTile(
            onTap: (){
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const UserProfileNotifications()));
            },
            title: const Text("User Profile Notifications"),
          ),
          ListTile(
            onTap: (){
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const UserProfileChats()));
            },
            title: const Text("User Profile Chats"),
          ),
          ListTile(
            onTap: (){
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const DormMGSetDateRange()));
            },
            title: const Text("Set Date Range"),
          ),
          ListTile(
            onTap: (){
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const DormMGEditDorm()));
            },
            title: const Text("DORM MG - Edit Dorm"),
          ),
          ListTile(
            onTap: (){
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const DormMGSendNotifications()));
            },
            title: const Text("DormMG SendNotifications"),
          ),
          ListTile(
            onTap: (){
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const DormOccupancyRates()));
            },
            title: const Text("Dorm Occupancy Rates"),
          ),
          ListTile(
            onTap: (){
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const DormMGManageRoom()));
            },
            title: const Text("DormMG ManageRoom"),
          ),
          ListTile(
            onTap: (){
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const DormMGPaymentStatus()));
            },
            title: const Text("DormMG PaymentStatus"),
          ),
          ListTile(
            onTap: (){
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const DormMGBookingHistory()));
            },
            title: const Text("DormMG BookingHistory"),
          ),
          ListTile(
            onTap: (){
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const DormMGReviewAndRatings()));
            },
            title: const Text("DormMG ReviewAndRatings"),
          ),
          ListTile(
            onTap: (){
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const AdminSendNotifications()));
            },
            title: const Text("Admin SendNotifications"),
          ),
          ListTile(
            onTap: (){
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const AdminManageDorm()));
            },
            title: const Text("Admin ManageDorm"),
          ),
          ListTile(
            onTap: (){
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const AdminAddDorm()));
            },
            title: const Text("Admin AddDorm"),
          ),
          ListTile(
            onTap: (){
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const AdminSendNotifications()));
            },
            title: const Text("Admin SendNotifications"),
          ),
          ListTile(
            onTap: (){
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const AdminSendNotifications()));
            },
            title: const Text("Admin SendNotifications"),
          ),
        ],
      ),
    );
  }



}