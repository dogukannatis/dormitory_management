import 'package:flutter/material.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 4,
      child: const Column(
        children: [
          ListTile(
            title: Text("Edit Profile"),
          ),
          ListTile(
            title: Text("View Dashboard"),
          ),
          ListTile(
            title: Text("Notifications"),
          )
        ],
      ),
    );
  }
}