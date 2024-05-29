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
import 'package:dormitory_management/ui/pages/systemadmin/admin_list_dormitories_page.dart';
import 'package:dormitory_management/ui/pages/systemadmin/admin_list_users_page.dart';
import 'package:dormitory_management/ui/pages/systemadmin/admin_send_notifications_page.dart';
import 'package:dormitory_management/ui/pages/systemadmin/admin_manage_dormitory_page.dart';
import 'package:dormitory_management/ui/pages/systemadmin/admin_add_dormitory_page.dart';
import 'package:dormitory_management/ui/pages/systemadmin/admin_edit_user_profile_page.dart';
import 'package:dormitory_management/viewmodels/user_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/users/admin.dart';
import '../../models/users/user.dart';

class CustomDrawer extends ConsumerStatefulWidget {
  final bool isActive;
  const CustomDrawer({
    super.key,
    this.isActive = false
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
      return _getDormitoryOwnerDrawer();
    }else if(user is Admin){
      return _getAdminDrawer();
    }else{
      return Container();
    }


  //return _getMockDrawer();

  }

  Widget _getStudentDrawer() {
    return SizedBox(
      width: 250,
      child: Drawer(
        child: ListView(
          children: [
            ListTile(
              onTap: (){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const EditProfilePage()));
              },
              title: Text("Edit Profile", style: widget.isActive ? TextStyle(color: Colors.green) : null,),
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
              title: const Text("Notifications"),
            ),
            ListTile(
              onTap: (){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const UserProfileChats()));
              },
              title: const Text("Chats"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getDormitoryOwnerDrawer() {
    return SizedBox(
      width: 250,
      child: Drawer(
        child: ListView(
          children: [
            ListTile(
              onTap: (){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const EditProfilePage()));
              },
              title: const Text("Edit Profile"),
            ),
            ListTile(
              onTap: (){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const DormMGEditDorm()));
              },
              title: const Text("Edit Dorm"),
            ),
            ListTile(
              onTap: (){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const DormMGSendNotifications()));
              },
              title: const Text("Send Notifications"),
            ),
            ListTile(
              onTap: (){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const DormOccupancyRates()));
              },
              title: const Text("Occupancy Rates"),
            ),
            ListTile(
              onTap: (){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const DormMGManageRoom()));
              },
              title: const Text("Manage Room"),
            ),
            ListTile(
              onTap: (){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const DormMGPaymentStatus()));
              },
              title: const Text("Payment Status"),
            ),
            ListTile(
              onTap: (){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const DormMGBookingHistory()));
              },
              title: const Text("Booking History"),
            ),
            ListTile(
              onTap: (){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const DormMGReviewAndRatings()));
              },
              title: const Text("Review And Ratings"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getAdminDrawer() {
    return SizedBox(
      width: 250,
      child: Drawer(
        child: ListView(
          children: [
            ListTile(
              onTap: (){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const EditProfilePage()));
              },
              title: const Text("Edit Profile"),
            ),
            ListTile(
              onTap: (){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const AdminSendNotifications()));
              },
              title: const Text("Send Notifications"),
            ),
            ListTile(
              onTap: (){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const AdminManageDorm()));
              },
              title: const Text("Manage Dorm"),
            ),
            ListTile(
              onTap: (){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const AdminAddDorm()));
              },
              title: const Text("Add Dorm"),
            ),
            ListTile(
              onTap: (){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const AdminListDorm()));
              },
              title: const Text("List Dorm"),
            ),
            ListTile(
              onTap: (){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const AdminListUser()));
              },
              title: const Text("List User"),
            ),
            ListTile(
              onTap: (){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const AdminEditUserProfile()));
              },
              title: const Text("Edit User Profile"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getMockDrawer(){
    return SizedBox(
      width: 250,
      child: Drawer(
        child: ListView(
          children: [
            ListTile(
              onTap: (){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const EditProfilePage()));
              },
              title: const Text("STD Edit Profile"),
            ),
            ListTile(
              onTap: (){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const UserProfileDormitory()));
              },
              title: const Text("STD My Dormitory"),
            ),
            ListTile(
              onTap: (){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const UserBookingHistory()));
              },
              title: const Text("STD Booking History"),
            ),
            ListTile(
              onTap: (){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const UserProfileNotifications()));
              },
              title: const Text("STD Notifications"),
            ),
            ListTile(
              onTap: (){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const UserProfileChats()));
              },
              title: const Text("STD Chats"),
            ),
            ListTile(
              onTap: (){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const DormMGSetDateRange()));
              },
              title: const Text("DORM Set Date Range"),
            ),
            ListTile(
              onTap: (){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const DormMGEditDorm()));
              },
              title: const Text("DORM Edit Dorm"),
            ),
            ListTile(
              onTap: (){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const DormMGSendNotifications()));
              },
              title: const Text("DORM Send Notifications"),
            ),
            ListTile(
              onTap: (){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const DormOccupancyRates()));
              },
              title: const Text("DORM Occupancy Rates"),
            ),
            ListTile(
              onTap: (){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const DormMGManageRoom()));
              },
              title: const Text("DORM Manage Room"),
            ),
            ListTile(
              onTap: (){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const DormMGPaymentStatus()));
              },
              title: const Text("DORM Payment Status"),
            ),
            ListTile(
              onTap: (){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const DormMGBookingHistory()));
              },
              title: const Text("DORM Booking History"),
            ),
            ListTile(
              onTap: (){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const DormMGReviewAndRatings()));
              },
              title: const Text("DORM Review And Ratings"),
            ),
            ListTile(
              onTap: (){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const AdminSendNotifications()));
              },
              title: const Text("ADMIN Send Notifications"),
            ),
            ListTile(
              onTap: (){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const AdminManageDorm()));
              },
              title: const Text("ADMIN Manage Dorm"),
            ),
            ListTile(
              onTap: (){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const AdminAddDorm()));
              },
              title: const Text("ADMIN Add Dorm"),
            ),
            ListTile(
              onTap: (){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const AdminListDorm()));
              },
              title: const Text("ADMIN List Dorm"),
            ),
            ListTile(
              onTap: (){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const AdminListUser()));
              },
              title: const Text("ADMIN List User"),
            ),
            ListTile(
              onTap: (){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const AdminEditUserProfile()));
              },
              title: const Text("ADMIN Edit User Profile"),
            ),
          ],
        ),
      ),
    );
  }



}