import 'package:dormitory_management/main.dart';
import 'package:dormitory_management/ui/pages/edit_profile_page.dart';
import 'package:dormitory_management/ui/pages/home_page.dart';
import 'package:dormitory_management/ui/widgets/custom_app_bar.dart';
import 'package:dormitory_management/ui/widgets/custom_drawer.dart';
import 'package:dormitory_management/ui/widgets/side_menu.dart';
import 'package:dormitory_management/ui/widgets/top_menu.dart';
import 'package:flutter/material.dart';


class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomePage(),
    );
  }
}
