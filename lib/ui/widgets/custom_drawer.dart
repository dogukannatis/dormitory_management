import 'package:dormitory_management/ui/pages/edit_profile_page.dart';
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
            onTap: (){},
            title: const Text("Dormitories"),
          ),
          ListTile(
            onTap: (){},
            title: const Text("Compare Dormitories"),
          ),
        ],
      ),
    );
  }
}