import 'package:dormitory_management/ui/pages/dorm_occupancy_rates_page.dart';
import 'package:dormitory_management/ui/pages/edit_profile_page.dart';
import 'package:dormitory_management/ui/pages/user_profile_dormitory.dart';
import 'package:dormitory_management/ui/pages/user_booking_history_page.dart';
import 'package:dormitory_management/ui/pages/user_profile_notifications_page.dart';
import 'package:dormitory_management/ui/pages/user_profile_chat_page.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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