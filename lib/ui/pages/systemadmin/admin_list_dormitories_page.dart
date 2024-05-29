import 'package:dormitory_management/ui/pages/systemadmin/admin_manage_dormitory_page.dart';
import 'package:dormitory_management/ui/widgets/custom_app_bar.dart';
import 'package:dormitory_management/ui/widgets/custom_drawer.dart';
import 'package:dormitory_management/viewmodels/dorm_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/dormitory.dart';


class AdminListDorm extends ConsumerStatefulWidget {
  const AdminListDorm({Key? key}) : super(key: key);

  @override
  ConsumerState createState() => _AdminListDormState();
}

class _AdminListDormState extends ConsumerState<AdminListDorm> {
  TextEditingController _dormitoryIdController = TextEditingController();
  String dormName = "";
  bool addRoom = false;
  bool isLoading = false;


  Future<void> getDormitories() async {
    final dormManager = ref.read(dormManagerProvider.notifier);
    setState(() {
      isLoading = true;
    });
    dormitories = await dormManager.getAllDormitories();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getDormitories();
    super.initState();
  }

  List<Dormitory> dormitories = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getCustomAppBar(context),
      body: isLoading ? const Center(
        child: CircularProgressIndicator(),
      ) : Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomDrawer(activePage: ActivePages.adminListDorm,),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  dormitories.isNotEmpty
                      ? SizedBox(
                    width: double.infinity,
                    height: 100,
                    child: ListView.builder(
                      itemCount: dormitories.length,
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Card(
                          color: Colors.white,
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Text(dormitories[index].name!),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => AdminManageDorm(dormitory: dormitories[index],)));

                                  },
                                  child: Text("Edit Dorm"),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  )
                      : Container(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}