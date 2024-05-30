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
import 'package:dormitory_management/ui/pages/systemadmin/admin_add_dormitory_page.dart';
import 'package:dormitory_management/viewmodels/user_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/users/admin.dart';
import '../../models/users/user.dart';

enum ActivePages {editProfilePage,userProfileDormitory, userBookingHistory, profileNotifications, profileChats, dormMGeditDorm, dormMGsetDateRange, dormMGsendNotifications, dormMGocuupancyRates, dormMGmanageRoom, dormMGpaymentStatus, dormMGbookingHistory, dormMGreviewsAndRatings, adminSendNotifications, adminManageDrom, adminAddDorm, adminListDorm, adminListUser, adminEditUserProfile, none}

class CustomDrawer extends ConsumerStatefulWidget {
  final ActivePages activePage;
  const CustomDrawer({
    super.key,
    this.activePage = ActivePages.none
  });

  @override
  ConsumerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends ConsumerState<CustomDrawer> {

  @override
  Widget build(BuildContext context) {
    User? user = ref.watch(userManagerProvider);


    if (user is Student) {
      return _getStudentDrawer();
    } else if (user is DormitoryOwner) {
      return _getDormitoryOwnerDrawer();
    } else if (user is Admin) {
      return _getAdminDrawer();
    } else {
      return Container();
    }


    //return _getMockDrawer();

  }

  Widget _getStudentDrawer() {
    return SizedBox(
      width: 300,
      child: Drawer(
        child: ListView(
          children: [
            ListTile(
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const EditProfilePage()));
              },
              leading: const Icon(Icons.edit),
              title: Text("Edit Profile",
                style: widget.activePage == ActivePages.editProfilePage
                    ? const TextStyle(color: Colors.blue)
                    : null,),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const UserProfileDormitory()));
              },
              leading: const Icon(Icons.home),
              title: Text("My Dormitory",
                style: widget.activePage == ActivePages.userProfileDormitory
                    ? const TextStyle(color: Colors.blue)
                    : null,),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const UserBookingHistory()));
              },
              leading: const Icon(Icons.history),
              title: Text("Booking History",
                style: widget.activePage == ActivePages.userBookingHistory
                    ? const TextStyle(color: Colors.blue)
                    : null,),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const UserProfileNotifications()));
              },
              leading: const Icon(Icons.notifications),
              title: Text("Notifications",
                style: widget.activePage == ActivePages.profileNotifications
                    ? const TextStyle(color: Colors.blue)
                    : null,),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const UserProfileChats()));
              },
              leading: const Icon(Icons.chat),
              title: Text("Chats",
                style: widget.activePage == ActivePages.profileChats
                    ? const TextStyle(color: Colors.blue)
                    : null,),
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
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const EditProfilePage()));
              },
              leading: const Icon(Icons.edit),
              title: Text("Edit Profile",
                style: widget.activePage == ActivePages.editProfilePage
                    ? const TextStyle(color: Colors.blue)
                    : null,),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const DormMGEditDorm()));
              },
              leading: const Icon(Icons.house),
              title: Text("Edit Dorm",
                style: widget.activePage == ActivePages.dormMGeditDorm
                    ? const TextStyle(color: Colors.blue)
                    : null,),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const DormMGSetDateRange()));
              },
              leading: const Icon(Icons.date_range),
              title: Text("Set Date Range",
                style: widget.activePage == ActivePages.dormMGsetDateRange
                    ? const TextStyle(color: Colors.blue)
                    : null,),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const DormMGSendNotifications()));
              },
              leading: const Icon(Icons.notifications),
              title: Text("Send Notifications",
                style: widget.activePage == ActivePages.dormMGsendNotifications
                    ? const TextStyle(color: Colors.blue)
                    : null,),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const DormMGOccupancyRates()));
              },
              leading: const Icon(Icons.rate_review),
              title: Text("Occupancy Rates",
                style: widget.activePage == ActivePages.dormMGocuupancyRates
                    ? const TextStyle(color: Colors.blue)
                    : null,),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const DormMGManageRoom()));
              },
              leading: const Icon(Icons.meeting_room),
              title: Text("Manage Room",
                style: widget.activePage == ActivePages.dormMGmanageRoom
                    ? const TextStyle(color: Colors.blue)
                    : null,),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const DormMGPaymentStatus()));
              },
              leading: const Icon(Icons.payment),
              title: Text("Payment Status",
                style: widget.activePage == ActivePages.dormMGpaymentStatus
                    ? const TextStyle(color: Colors.blue)
                    : null,),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const DormMGBookingHistory()));
              },
              leading: const Icon(Icons.history),
              title: Text("Booking History",
                style: widget.activePage == ActivePages.dormMGbookingHistory
                    ? const TextStyle(color: Colors.blue)
                    : null,),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const DormMGReviewAndRatings()));
              },
              leading: const Icon(Icons.reviews),
              title: Text("Review And Ratings",
                style: widget.activePage == ActivePages.dormMGreviewsAndRatings
                    ? const TextStyle(color: Colors.blue)
                    : null,),
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
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const EditProfilePage()));
              },
              leading: const Icon(Icons.edit),
              title: Text("Edit Profile",
                style: widget.activePage == ActivePages.editProfilePage
                    ? const TextStyle(color: Colors.blue)
                    : null,),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const AdminSendNotifications()));
              },
              leading: const Icon(Icons.notifications),
              title: Text("Send Notifications",
                style: widget.activePage == ActivePages.adminSendNotifications
                    ? const TextStyle(color: Colors.blue)
                    : null,),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const AdminAddDorm()));
              },
              leading: const Icon(Icons.add_circle_outline),
              title: Text("Add Dorm",
                style: widget.activePage == ActivePages.adminAddDorm
                    ? const TextStyle(color: Colors.blue)
                    : null,),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const AdminListDorm()));
              },
              leading: const Icon(Icons.list_alt),
              title: Text("List Dorm",
                style: widget.activePage == ActivePages.adminListDorm
                    ? const TextStyle(color: Colors.blue)
                    : null,),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const AdminListUser()));
              },
              leading: const Icon(Icons.people),
              title: Text("List User",
                style: widget.activePage == ActivePages.adminListUser
                    ? const TextStyle(color: Colors.blue)
                    : null,),
            ),
            /*
            ListTile(
              onTap: (){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const AdminEditUserProfile()));
              },
              title: Text("Edit User Profile", style: widget.activePage == ActivePages.adminEditUserProfile ? TextStyle(color: Colors.blue) : null,),
            ),
             */
          ],
        ),
      ),
    );
  }

  /// This is mock drawer for development only (DEBUG)
  Widget _getMockDrawer() {
    return SizedBox(
      width: 250,
      child: Drawer(
        child: ListView(
          children: [
            ListTile(
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const EditProfilePage()));
              },
              title: Text("STD Edit Profile",
                style: widget.activePage == ActivePages.editProfilePage
                    ? const TextStyle(color: Colors.blue)
                    : null,),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const UserProfileDormitory()));
              },
              title: Text("STD My Dormitory",
                style: widget.activePage == ActivePages.userProfileDormitory
                    ? const TextStyle(color: Colors.blue)
                    : null,),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const UserBookingHistory()));
              },
              title: Text("STD Booking History",
                style: widget.activePage == ActivePages.userBookingHistory
                    ? const TextStyle(color: Colors.blue)
                    : null,),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const UserProfileNotifications()));
              },
              title: Text("STD Notifications",
                style: widget.activePage == ActivePages.profileNotifications
                    ? const TextStyle(color: Colors.blue)
                    : null,),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const UserProfileChats()));
              },
              title: Text("STD Chats",
                style: widget.activePage == ActivePages.profileChats
                    ? const TextStyle(color: Colors.blue)
                    : null,),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const DormMGSetDateRange()));
              },
              title: Text("DORM Set Date Range",
                style: widget.activePage == ActivePages.dormMGsetDateRange
                    ? const TextStyle(color: Colors.blue)
                    : null,),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const DormMGEditDorm()));
              },
              title: Text("DORM Edit Dorm",
                style: widget.activePage == ActivePages.dormMGeditDorm
                    ? const TextStyle(color: Colors.blue)
                    : null,),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const DormMGSendNotifications()));
              },
              title: Text("DORM Send Notifications",
                style: widget.activePage == ActivePages.dormMGsendNotifications
                    ? const TextStyle(color: Colors.blue)
                    : null,),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const DormMGOccupancyRates()));
              },
              title: Text("DORM Occupancy Rates",
                style: widget.activePage == ActivePages.dormMGocuupancyRates
                    ? const TextStyle(color: Colors.blue)
                    : null,),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const DormMGManageRoom()));
              },
              title: Text("DORM Manage Room",
                style: widget.activePage == ActivePages.dormMGmanageRoom
                    ? const TextStyle(color: Colors.blue)
                    : null,),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const DormMGPaymentStatus()));
              },
              title: Text("DORM Payment Status",
                style: widget.activePage == ActivePages.dormMGpaymentStatus
                    ? const TextStyle(color: Colors.blue)
                    : null,),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const DormMGBookingHistory()));
              },
              title: Text("DORM Booking History",
                style: widget.activePage == ActivePages.dormMGbookingHistory
                    ? const TextStyle(color: Colors.blue)
                    : null,),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const DormMGReviewAndRatings()));
              },
              title: Text("DORM Review And Ratings",
                style: widget.activePage == ActivePages.dormMGreviewsAndRatings
                    ? const TextStyle(color: Colors.blue)
                    : null,),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const AdminSendNotifications()));
              },
              title: Text("ADMIN Send Notifications",
                style: widget.activePage == ActivePages.adminSendNotifications
                    ? const TextStyle(color: Colors.blue)
                    : null,),
            ),
            /*
            ListTile(
              onTap: (){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const AdminManageDorm()));
              },
              title: Text("ADMIN Manage Dorm", style: widget.activePage == ActivePages.adminManageDrom ? TextStyle(color: Colors.blue) : null,),
            ),
            */
            ListTile(
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const AdminAddDorm()));
              },
              title: Text("ADMIN Add Dorm",
                style: widget.activePage == ActivePages.adminAddDorm
                    ? const TextStyle(color: Colors.blue)
                    : null,),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const AdminListDorm()));
              },
              title: Text("ADMIN List Dorm",
                style: widget.activePage == ActivePages.adminListDorm
                    ? const TextStyle(color: Colors.blue)
                    : null,),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const AdminListUser()));
              },
              title: Text("ADMIN List User",
                style: widget.activePage == ActivePages.adminListUser
                    ? const TextStyle(color: Colors.blue)
                    : null,),
            ),

          ],
        ),
      ),
    );
  }


}