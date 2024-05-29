import 'package:dormitory_management/models/users/admin.dart';
import 'package:dormitory_management/models/users/student.dart';
import 'package:dormitory_management/ui/pages/systemadmin/admin_edit_user_profile_page.dart';
import 'package:dormitory_management/ui/widgets/custom_app_bar.dart';
import 'package:dormitory_management/ui/widgets/custom_drawer.dart';
import 'package:dormitory_management/viewmodels/user_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/users/user.dart';



class AdminListUser extends ConsumerStatefulWidget {
  const AdminListUser({Key? key}) : super(key: key);

  @override
  ConsumerState createState() => _AdminListUserState();
}

class _AdminListUserState extends ConsumerState<AdminListUser> {
  List<User> users = [];

  bool isLoading = false;

  Future<void> getUsers() async {
    final userManager = ref.read(userManagerProvider.notifier);

    setState(() {
      isLoading = true;
    });
    users = await userManager.getAllUsers();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getUsers();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getCustomAppBar(context),
      drawer: const CustomDrawer(),
      body: isLoading ? const Center(
        child: CircularProgressIndicator(),
      ) : Padding(
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
                title: Text("${users[index].name} ${users[index].surName}"),
                subtitle: Text(users[index].email ?? ''),
                trailing: Text(users[index].userType!),
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => AdminEditUserProfile(user: users[index])));

                },
              ),
            );
          },
        ),
      ),
    );
  }
}