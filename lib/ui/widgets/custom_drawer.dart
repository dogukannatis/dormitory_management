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
            onTap: (){},
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
