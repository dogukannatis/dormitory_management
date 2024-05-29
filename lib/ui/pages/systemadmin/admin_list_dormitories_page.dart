import 'package:dormitory_management/ui/widgets/custom_app_bar.dart';
import 'package:dormitory_management/ui/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';

class Dormitory {
  final String name;
  final int dormitoryId;

  Dormitory({required this.name, required this.dormitoryId});
}

class AdminListDorm extends StatefulWidget {
  const AdminListDorm({Key? key}) : super(key: key);

  @override
  State<AdminListDorm> createState() => _AdminListDormState();
}

class _AdminListDormState extends State<AdminListDorm> {
  TextEditingController _dormitoryIdController = TextEditingController();
  String dormName = "";
  bool addRoom = false;

  List<Dormitory> dormitories = [
    Dormitory(name: "Dorm 1", dormitoryId: 1),
    Dormitory(name: "Dorm 2", dormitoryId: 2),
    Dormitory(name: "Dorm 3", dormitoryId: 2),
    Dormitory(name: "Dorm 4", dormitoryId: 2),
    Dormitory(name: "Dorm 5", dormitoryId: 2),
    Dormitory(name: "Dorm 6", dormitoryId: 2),
    Dormitory(name: "Dorm 7", dormitoryId: 2),
    Dormitory(name: "Dorm 8", dormitoryId: 2),
    Dormitory(name: "Dorm 9", dormitoryId: 2),
    Dormitory(name: "Dorm 10", dormitoryId: 2),
    Dormitory(name: "Dorm 11", dormitoryId: 2),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getCustomAppBar(context),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomDrawer(),
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
                                Text(dormitories[index].name),
                                ElevatedButton(
                                  onPressed: () {
                                    _dormitoryIdController.text =
                                        dormitories[index]
                                            .dormitoryId
                                            .toString();
                                    dormName = dormitories[index].name;
                                    setState(() {
                                      addRoom = true;
                                    });
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