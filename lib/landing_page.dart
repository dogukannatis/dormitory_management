import 'package:dormitory_management/models/users/dormitory_owner.dart';
import 'package:dormitory_management/models/users/student.dart';
import 'package:dormitory_management/ui/pages/home_page.dart';
import 'package:dormitory_management/viewmodels/user_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'models/users/admin.dart';
import 'models/users/user.dart';


class LandingPage extends ConsumerStatefulWidget {
  const LandingPage({super.key});

  @override
  ConsumerState createState() => _LandingPageState();
}

class _LandingPageState extends ConsumerState<LandingPage> {
  @override
  Widget build(BuildContext context) {

    User? user = ref.watch(userManagerProvider);

    if(user is Student){
      return const Scaffold(
        body: HomePage(), // Student page
      );
    }else if(user is DormitoryOwner){
      return const Scaffold(
        body: HomePage(), // Dormitory owner page
      );
    }else if(user is Admin){
      return const Scaffold(
        body: HomePage(), // Admin page
      );
    }else{
      return const Scaffold(
        body: HomePage(), // Home page
      );
    }

  }
}
