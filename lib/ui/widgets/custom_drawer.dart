import 'package:dormitory_management/models/users/dormitory_owner.dart';
import 'package:dormitory_management/models/users/student.dart';
import 'package:dormitory_management/ui/pages/dorm_occupancy_rates_page.dart';
import 'package:dormitory_management/ui/pages/edit_profile_page.dart';
import 'package:dormitory_management/ui/pages/user_profile_dormitory.dart';
import 'package:dormitory_management/ui/pages/user_booking_history_page.dart';
import 'package:dormitory_management/ui/pages/user_profile_notifications_page.dart';
import 'package:dormitory_management/ui/pages/user_profile_chat_page.dart';
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
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const DormOccupancyRates()));
            },
            title: const Text("Dorm Occupancy Rates"),
          ),
          ListTile(
            onTap: (){
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const DormOccupancyRates()));
            },
            title: const Text("Dorm Occupancy Rates"),
          ),
          ListTile(
            onTap: (){
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const DormOccupancyRates()));
            },
            title: const Text("Dorm Occupancy Rates"),
          ),
          ListTile(
            onTap: (){
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const DormOccupancyRates()));
            },
            title: const Text("Dorm Occupancy Rates"),
          ),

        ],
      ),
    );
  }



}