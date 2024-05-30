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
      width: 300,
      child: Drawer(
        child: ListView(
          children: [
            ListTile(
              onTap: (){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const EditProfilePage()));
              },
              leading: Icon(Icons.edit),
              title: Text("Edit Profile", style: widget.activePage == ActivePages.editProfilePage ? TextStyle(color: Colors.blue) : null,),
            ),
            ListTile(
              onTap: (){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const UserProfileDormitory()));
              },
              leading: Icon(Icons.home),
              title: Text("My Dormitory", style: widget.activePage == ActivePages.userProfileDormitory ? TextStyle(color: Colors.blue) : null,),
            ),
            ListTile(
              onTap: (){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const UserBookingHistory()));
              },
              leading: Icon(Icons.history),
              title: Text("Booking History", style: widget.activePage == ActivePages.userBookingHistory ? TextStyle(color: Colors.blue) : null,),
            ),
            ListTile(
              onTap: (){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const UserProfileNotifications()));
              },
              leading: Icon(Icons.notifications),
              title: Text("Notifications", style: widget.activePage == ActivePages.profileNotifications ? TextStyle(color: Colors.blue) : null,),
            ),
            ListTile(
              onTap: (){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const UserProfileChats()));
              },
              leading: Icon(Icons.chat),
              title: Text("Chats", style: widget.activePage == ActivePages.profileChats ? TextStyle(color: Colors.blue) : null,),
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
              leading: Icon(Icons.edit),
              title: Text("Edit Profile", style: widget.activePage == ActivePages.editProfilePage ? TextStyle(color: Colors.blue) : null,),
            ),
            ListTile(
              onTap: (){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const DormMGEditDorm()));
              },
              leading: Icon(Icons.house),
              title: Text("Edit Dorm", style: widget.activePage == ActivePages.dormMGeditDorm ? TextStyle(color: Colors.blue) : null,),
            ),
            ListTile(
              onTap: (){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const DormMGSetDateRange()));
              },
              leading: Icon(Icons.date_range),
              title: Text("Set Date Range", style: widget.activePage == ActivePages.dormMGsetDateRange ? TextStyle(color: Colors.blue) : null,),
            ),
            ListTile(
              onTap: (){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const DormMGSendNotifications()));
              },
              leading: Icon(Icons.notifications),
              title: Text("Send Notifications", style: widget.activePage == ActivePages.dormMGsendNotifications ? TextStyle(color: Colors.blue) : null,),
            ),
            ListTile(
              onTap: (){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const DormMGOccupancyRates()));
              },
              leading: Icon(Icons.rate_review),
              title: Text("Occupancy Rates", style: widget.activePage == ActivePages.dormMGocuupancyRates ? TextStyle(color: Colors.blue) : null,),
            ),
            ListTile(
              onTap: (){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const DormMGManageRoom()));
              },
              leading: Icon(Icons.meeting_room),
              title: Text("Manage Room", style: widget.activePage == ActivePages.dormMGmanageRoom ? TextStyle(color: Colors.blue) : null,),
            ),
            ListTile(
              onTap: (){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const DormMGPaymentStatus()));
              },
              leading: Icon(Icons.payment),
              title: Text("Payment Status", style: widget.activePage == ActivePages.dormMGpaymentStatus ? TextStyle(color: Colors.blue) : null,),
            ),
            ListTile(
              onTap: (){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const DormMGBookingHistory()));
              },
              leading: Icon(Icons.history),
              title: Text("Booking History", style: widget.activePage == ActivePages.dormMGbookingHistory ? TextStyle(color: Colors.blue) : null,),
            ),
            ListTile(
              onTap: (){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const DormMGReviewAndRatings()));
              },
              leading: Icon(Icons.reviews),
              title: Text("Review And Ratings", style: widget.activePage == ActivePages.dormMGreviewsAndRatings ? TextStyle(color: Colors.blue) : null,),
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
              leading: Icon(Icons.edit),
              title: Text("Edit Profile", style: widget.activePage == ActivePages.editProfilePage ? TextStyle(color: Colors.blue) : null,),
            ),
            ListTile(
              onTap: (){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const AdminSendNotifications()));
              },
              leading: Icon(Icons.notifications),
              title: Text("Send Notifications", style: widget.activePage == ActivePages.adminSendNotifications ? TextStyle(color: Colors.blue) : null,),
            ),
           /*
            ListTile(
              onTap: (){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const AdminManageDorm()));
              },
              leading: Icon(Icons.add_business),
              title: Text("Manage Dorm", style: widget.activePage == ActivePages.adminManageDrom ? TextStyle(color: Colors.blue) : null,),
            ),
            */
            ListTile(
              onTap: (){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const AdminAddDorm()));
              },
              leading: Icon(Icons.add_circle_outline),
              title: Text("Add Dorm", style: widget.activePage == ActivePages.adminAddDorm ? TextStyle(color: Colors.blue) : null,),
            ),
            ListTile(
              onTap: (){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const AdminListDorm()));
              },
              leading: Icon(Icons.list_alt),
              title: Text("List Dorm", style: widget.activePage == ActivePages.adminListDorm ? TextStyle(color: Colors.blue) : null,),
            ),
            ListTile(
              onTap: (){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const AdminListUser()));
              },
              leading: Icon(Icons.people),
              title: Text("List User", style: widget.activePage == ActivePages.adminListUser ? TextStyle(color: Colors.blue) : null,),
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
              title: Text("STD Edit Profile", style: widget.activePage == ActivePages.editProfilePage ? TextStyle(color: Colors.blue) : null,),
            ),
            ListTile(
              onTap: (){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const UserProfileDormitory()));
              },
              title: Text("STD My Dormitory", style: widget.activePage == ActivePages.userProfileDormitory ? TextStyle(color: Colors.blue) : null,),
            ),
            ListTile(
              onTap: (){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const UserBookingHistory()));
              },
              title: Text("STD Booking History", style: widget.activePage == ActivePages.userBookingHistory ? TextStyle(color: Colors.blue) : null,),
            ),
            ListTile(
              onTap: (){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const UserProfileNotifications()));
              },
              title: Text("STD Notifications", style: widget.activePage == ActivePages.profileNotifications ? TextStyle(color: Colors.blue) : null,),
            ),
            ListTile(
              onTap: (){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const UserProfileChats()));
              },
              title: Text("STD Chats", style: widget.activePage == ActivePages.profileChats ? TextStyle(color: Colors.blue) : null,),
            ),
            ListTile(
              onTap: (){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const DormMGSetDateRange()));
              },
              title: Text("DORM Set Date Range", style: widget.activePage == ActivePages.dormMGsetDateRange ? TextStyle(color: Colors.blue) : null,),
            ),
            ListTile(
              onTap: (){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const DormMGEditDorm()));
              },
              title: Text("DORM Edit Dorm", style: widget.activePage == ActivePages.dormMGeditDorm ? TextStyle(color: Colors.blue) : null,),
            ),
            ListTile(
              onTap: (){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const DormMGSendNotifications()));
              },
              title: Text("DORM Send Notifications", style: widget.activePage == ActivePages.dormMGsendNotifications ? TextStyle(color: Colors.blue) : null,),
            ),
            ListTile(
              onTap: (){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const DormMGOccupancyRates()));
              },
              title: Text("DORM Occupancy Rates", style: widget.activePage == ActivePages.dormMGocuupancyRates ? TextStyle(color: Colors.blue) : null,),
            ),
            ListTile(
              onTap: (){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const DormMGManageRoom()));
              },
              title: Text("DORM Manage Room", style: widget.activePage == ActivePages.dormMGmanageRoom ? TextStyle(color: Colors.blue) : null,),
            ),
            ListTile(
              onTap: (){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const DormMGPaymentStatus()));
              },
              title: Text("DORM Payment Status", style: widget.activePage == ActivePages.dormMGpaymentStatus ? TextStyle(color: Colors.blue) : null,),
            ),
            ListTile(
              onTap: (){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const DormMGBookingHistory()));
              },
              title: Text("DORM Booking History", style: widget.activePage == ActivePages.dormMGbookingHistory ? TextStyle(color: Colors.blue) : null,),
            ),
            ListTile(
              onTap: (){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const DormMGReviewAndRatings()));
              },
              title: Text("DORM Review And Ratings", style: widget.activePage == ActivePages.dormMGreviewsAndRatings ? TextStyle(color: Colors.blue) : null,),
            ),
            ListTile(
              onTap: (){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const AdminSendNotifications()));
              },
              title: Text("ADMIN Send Notifications", style: widget.activePage == ActivePages.adminSendNotifications ? TextStyle(color: Colors.blue) : null,),
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
              onTap: (){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const AdminAddDorm()));
              },
              title: Text("ADMIN Add Dorm", style: widget.activePage == ActivePages.adminAddDorm ? TextStyle(color: Colors.blue) : null,),
            ),
            ListTile(
              onTap: (){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const AdminListDorm()));
              },
              title: Text("ADMIN List Dorm", style: widget.activePage == ActivePages.adminListDorm ? TextStyle(color: Colors.blue) : null,),
            ),
            ListTile(
              onTap: (){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const AdminListUser()));
              },
              title: Text("ADMIN List User", style: widget.activePage == ActivePages.adminListUser ? TextStyle(color: Colors.blue) : null,),
            ),
           /*
            ListTile(
              onTap: (){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const AdminEditUserProfile()));
              },
              leading: Icon(Icons.edit),
              title: Text("ADMIN Edit User Profile", style: widget.activePage == ActivePages.adminEditUserProfile ? TextStyle(color: Colors.blue) : null,),
            ),
            */
          ],
        ),
      ),
    );
  }



}






















/*

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

enum ActivePages {
  editProfilePage,
  userProfileDormitory,
  userBookingHistory,
  profileNotifications,
  profileChats,
  dormMGeditDorm,
  dormMGsetDateRange,
  dormMGsendNotifications,
  dormMGocuupancyRates,
  dormMGmanageRoom,
  dormMGpaymentStatus,
  dormMGbookingHistory,
  dormMGreviewsAndRatings,
  adminSendNotifications,
  adminManageDrom,
  adminAddDorm,
  adminListDorm,
  adminListUser,
  adminEditUserProfile,
  none
}

class CustomDrawer extends ConsumerStatefulWidget {
  final ActivePages activePage;
  const CustomDrawer({
    super.key,
    this.activePage = ActivePages.none,
  });

  @override
  ConsumerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends ConsumerState<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    User? user = ref.watch(userManagerProvider);

    return _getMockDrawer();
  }

  Widget _getStudentDrawer() {
    return SizedBox(
      width: 250,
      child: Drawer(
        child: ListView(
          children: [
            ListTile(
              leading: Icon(Icons.edit),
              onTap: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const EditProfilePage()));
              },
              title: Text(
                "Edit Profile",
                style: widget.activePage == ActivePages.editProfilePage
                    ? TextStyle(color: Colors.blue)
                    : null,
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const UserProfileDormitory()));
              },
              title: Text(
                "My Dormitory",
                style: widget.activePage == ActivePages.userProfileDormitory
                    ? TextStyle(color: Colors.blue)
                    : null,
              ),
            ),
            ListTile(
              leading: Icon(Icons.history),
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const UserBookingHistory()));
              },
              title: Text(
                "Booking History",
                style: widget.activePage == ActivePages.userBookingHistory
                    ? TextStyle(color: Colors.blue)
                    : null,
              ),
            ),
            ListTile(
              leading: Icon(Icons.notifications),
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const UserProfileNotifications()));
              },
              title: Text(
                "Notifications",
                style: widget.activePage == ActivePages.profileNotifications
                    ? TextStyle(color: Colors.blue)
                    : null,
              ),
            ),
            ListTile(
              leading: Icon(Icons.chat),
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const UserProfileChats()));
              },
              title: Text(
                "Chats",
                style: widget.activePage == ActivePages.profileChats
                    ? TextStyle(color: Colors.blue)
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Benzer şekilde diğer fonksiyonlarda da icon ekleyebilirsiniz.
  // Örneğin _getDormitoryOwnerDrawer ve _getAdminDrawer fonksiyonlarında:

  Widget _getDormitoryOwnerDrawer() {
    return SizedBox(
      width: 250,
      child: Drawer(
        child: ListView(
          children: [
            ListTile(
              leading: Icon(Icons.edit),
              onTap: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const EditProfilePage()));
              },
              title: Text(
                "Edit Profile",
                style: widget.activePage == ActivePages.editProfilePage
                    ? TextStyle(color: Colors.blue)
                    : null,
              ),
            ),
            ListTile(
              leading: Icon(Icons.edit),
              onTap: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const DormMGEditDorm()));
              },
              title: Text(
                "Edit Dorm",
                style: widget.activePage == ActivePages.dormMGeditDorm
                    ? TextStyle(color: Colors.blue)
                    : null,
              ),
            ),
            ListTile(
              leading: Icon(Icons.date_range),
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const DormMGSetDateRange()));
              },
              title: Text(
                "Set Date Range",
                style: widget.activePage == ActivePages.dormMGsetDateRange
                    ? TextStyle(color: Colors.blue)
                    : null,
              ),
            ),
            ListTile(
              leading: Icon(Icons.notifications),
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const DormMGSendNotifications()));
              },
              title: Text(
                "Send Notifications",
                style: widget.activePage == ActivePages.dormMGsendNotifications
                    ? TextStyle(color: Colors.blue)
                    : null,
              ),
            ),
            ListTile(
              leading: Icon(Icons.rate_review),
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const DormMGOccupancyRates()));
              },
              title: Text(
                "Occupancy Rates",
                style: widget.activePage == ActivePages.dormMGocuupancyRates
                    ? TextStyle(color: Colors.blue)
                    : null,
              ),
            ),
            ListTile(
              leading: Icon(Icons.meeting_room),
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const DormMGManageRoom()));
              },
              title: Text(
                "Manage Room",
                style: widget.activePage == ActivePages.dormMGmanageRoom
                    ? TextStyle(color: Colors.blue)
                    : null,
              ),
            ),
            ListTile(
              leading: Icon(Icons.payment),
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const DormMGPaymentStatus()));
              },
              title: Text(
                "Payment Status",
                style: widget.activePage == ActivePages.dormMGpaymentStatus
                    ? TextStyle(color: Colors.blue)
                    : null,
              ),
            ),
            ListTile(
              leading: Icon(Icons.history),
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const DormMGBookingHistory()));
              },
              title: Text(
                "Booking History",
                style: widget.activePage == ActivePages.dormMGbookingHistory
                    ? TextStyle(color: Colors.blue)
                    : null,
              ),
            ),
            ListTile(
              leading: Icon(Icons.reviews),
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const DormMGReviewAndRatings()));
              },
              title: Text(
                "Review And Ratings",
                style: widget.activePage == ActivePages.dormMGreviewsAndRatings
                    ? TextStyle(color: Colors.blue)
                    : null,
              ),
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
              leading: Icon(Icons.notifications),
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const AdminSendNotifications()));
              },
              title: Text(
                "Send Notifications",
                style: widget.activePage == ActivePages.adminSendNotifications
                    ? TextStyle(color: Colors.blue)
                    : null,
              ),
            ),
            ListTile(
              leading: Icon(Icons.add_business),
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const AdminManageDorm()));
              },
              title: Text(
                "Manage Dormitory",
                style: widget.activePage == ActivePages.adminManageDrom
                    ? TextStyle(color: Colors.blue)
                    : null,
              ),
            ),
            ListTile(
              leading: Icon(Icons.add_circle_outline),
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const AdminAddDorm()));
              },
              title: Text(
                "Add Dormitory",
                style: widget.activePage == ActivePages.adminAddDorm
                    ? TextStyle(color: Colors.blue)
                    : null,
              ),
            ),
            ListTile(
              leading: Icon(Icons.list_alt),
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const AdminListDorm()));
              },
              title: Text(
                "List Dormitories",
                style: widget.activePage == ActivePages.adminListDorm
                    ? TextStyle(color: Colors.blue)
                    : null,
              ),
            ),
            ListTile(
              leading: Icon(Icons.people),
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const AdminListUser()));
              },
              title: Text(
                "List Users",
                style: widget.activePage == ActivePages.adminListUser
                    ? TextStyle(color: Colors.blue)
                    : null,
              ),
            ),
            ListTile(
              leading: Icon(Icons.edit),
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const AdminEditUserProfile()));
              },
              title: Text(
                "Edit User Profile",
                style: widget.activePage == ActivePages.adminEditUserProfile
                    ? TextStyle(color: Colors.blue)
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getMockDrawer() {
    return SizedBox(
      width: 250,
      child: Drawer(
        child: ListView(
          children: [
            const ListTile(
              leading: Icon(Icons.edit),
              title: Text("Edit Profile"),
            ),
            const ListTile(
              leading: Icon(Icons.home),
              title: Text("My Dormitory"),
            ),
            const ListTile(
              leading: Icon(Icons.history),
              title: Text("Booking History"),
            ),
            const ListTile(
              leading: Icon(Icons.notifications),
              title: Text("Notifications"),
            ),
            const ListTile(
              leading: Icon(Icons.chat),
              title: Text("Chats"),
            ),
            const ListTile(
              leading: Icon(Icons.edit),
              title: Text("Edit Dorm"),
            ),
            const ListTile(
              leading: Icon(Icons.date_range),
              title: Text("Set Date Range"),
            ),
            const ListTile(
              leading: Icon(Icons.notifications),
              title: Text("Send Notifications"),
            ),
            const ListTile(
              leading: Icon(Icons.rate_review),
              title: Text("Occupancy Rates"),
            ),
            const ListTile(
              leading: Icon(Icons.meeting_room),
              title: Text("Manage Room"),
            ),
            const ListTile(
              leading: Icon(Icons.payment),
              title: Text("Payment Status"),
            ),
            const ListTile(
              leading: Icon(Icons.history),
              title: Text("Booking History"),
            ),
            const ListTile(
              leading: Icon(Icons.reviews),
              title: Text("Review And Ratings"),
            ),
            const ListTile(
              leading: Icon(Icons.notifications),
              title: Text("Send Notifications"),
            ),
            const ListTile(
              leading: Icon(Icons.add_business),
              title: Text("Manage Dormitory"),
            ),
            const ListTile(
              leading: Icon(Icons.add_circle_outline),
              title: Text("Add Dormitory"),
            ),
            const ListTile(
              leading: Icon(Icons.list_alt),
              title: Text("List Dormitories"),
            ),
            const ListTile(
              leading: Icon(Icons.people),
              title: Text("List Users"),
            ),
            const ListTile(
              leading: Icon(Icons.edit),
              title: Text("Edit User Profile"),
            ),
          ],
        ),
      ),
    );
  }
}

*/