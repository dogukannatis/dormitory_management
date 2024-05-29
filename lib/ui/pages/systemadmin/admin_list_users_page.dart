import 'package:dormitory_management/models/users/admin.dart';
import 'package:dormitory_management/models/users/student.dart';
import 'package:dormitory_management/ui/widgets/custom_app_bar.dart';
import 'package:dormitory_management/ui/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import '../../../models/users/user.dart';

class AdminListUser extends StatefulWidget {
  const AdminListUser({Key? key}) : super(key: key);

  @override
  State<AdminListUser> createState() => _AdminListUserState();
}

class _AdminListUserState extends State<AdminListUser> {
  List<User> users = [
    Admin(
      userId: 1,
      email: 'admin@example.com',
      name: 'Admin',
      surName: 'User',
    ),
    Student(
      userId: 2,
      email: 'user@example.com',
      name: 'Student',
      surName: 'User',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getCustomAppBar(context),
      drawer: const CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                title: Text(users[index].name ?? ''),
                subtitle: Text(users[index].email ?? ''),
                onTap: () {
                },
              ),
            );
          },
        ),
      ),
    );
  }
}