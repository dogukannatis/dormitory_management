import 'package:dormitory_management/ui/widgets/button_loading.dart';
import 'package:dormitory_management/ui/widgets/custom_app_bar.dart';
import 'package:dormitory_management/ui/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/users/admin.dart';
import '../../../models/users/dormitory_owner.dart';
import '../../../models/users/student.dart';
import '../../../models/users/user.dart';
import '../../../viewmodels/user_manager.dart';


class AdminEditUserProfile extends ConsumerStatefulWidget {
  final User user;
  const AdminEditUserProfile({Key? key, required this.user}) : super(key: key);

  @override
  ConsumerState createState() => _AdminEditUserProfileState();
}

class _AdminEditUserProfileState extends ConsumerState<AdminEditUserProfile> {

  final _formKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController surnameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController passwordController;

  bool isSaving = false;

  @override
  void initState() {
    nameController = TextEditingController(text: widget.user.name);
    surnameController = TextEditingController(text: widget.user.surName);
    emailController = TextEditingController(text: widget.user.email);
    phoneController = TextEditingController(text: widget.user.phoneNo);
    passwordController = TextEditingController();

    super.initState();
  }


  Future<void> updateUser() async {
    final userManager = ref.read(userManagerProvider.notifier);

    setState(() {
      isSaving = true;
    });
    if (widget.user is Student) {
      Student? tempUser = Student(
        userId: widget.user?.userId,
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        name: nameController.text.trim(),
        surName: surnameController.text.trim(),
        phoneNo: phoneController.text.trim(),
        dob: widget.user?.dob,
        createdAt: widget.user?.createdAt,
        updatedAt: widget.user?.updatedAt,
        department: (widget.user as Student).department,
        gender: (widget.user as Student).gender,
        profileUrl: widget.user.profileUrl,
        isEmailVerified: widget.user.isEmailVerified,
        emergencyContactNo: (widget.user as Student).emergencyContactNo,
        address: widget.user.address,
        studentNumber: (widget.user as Student).studentNumber,
        userType: widget.user.userType,
      );

      await userManager.updateStudent(user: tempUser, disableState: true);
    } else if (widget.user is DormitoryOwner) {
      DormitoryOwner? tempUser = DormitoryOwner(
        userId: widget.user.userId,
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        name: nameController.text.trim(),
        surName: surnameController.text.trim(),
        phoneNo: phoneController.text.trim(),
        dob: widget.user.dob,
        createdAt: widget.user.createdAt,
        updatedAt: widget.user.updatedAt,
        profileUrl: widget.user.profileUrl,
        isEmailVerified: widget.user.isEmailVerified,
        address: widget.user.address,
        dormitoryId: (widget.user as DormitoryOwner).dormitoryId,
        userType: widget.user.userType,
      );

      await userManager.updateDormitoryOwner(user: tempUser, disableState: true);
    } else if (widget.user is Admin) {
      Admin? tempUser = Admin(
        userId: widget.user.userId,
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        name: nameController.text.trim(),
        surName: surnameController.text.trim(),
        phoneNo: phoneController.text.trim(),
        dob: widget.user.dob,
        createdAt: widget.user.createdAt,
        updatedAt: widget.user.updatedAt,
        profileUrl: widget.user.profileUrl,
        isEmailVerified: widget.user.isEmailVerified,
        address: widget.user.address,
        userType: widget.user.userType,
      );

      await userManager.updateAdmin(user: tempUser, disableState: true);
    }

    setState(() {
      isSaving = false;
    });

    const snackBar = SnackBar(
      content: Text('Profile has been updated!'),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getCustomAppBar(context),
      drawer: const CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Align(
          alignment: Alignment.topLeft,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                color: Colors.white,
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Container(
                  height: 515,
                  width: 280,
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      widget.user.profileUrl != null &&
                          widget.user.profileUrl != "string" ? CircleAvatar(
                        radius: 100,
                        backgroundImage:
                        NetworkImage(widget.user.profileUrl!),
                        backgroundColor: Colors.black,
                      ) : const CircleAvatar(
                        radius: 100,
                        backgroundImage:
                        AssetImage('assets/images/login_access.png'),
                        backgroundColor: Colors.black,
                      ),
                      const SizedBox(height: 10),
                      TextButton(
                        onPressed: () {
                        },
                        child: Text('Upload Profile Photo'),
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Divider(color: Colors.grey.shade300),
                      Text("${widget.user.name} ${widget.user.surName}",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Turkey',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.person, size: 16, color: Colors.grey),
                          SizedBox(width: 5),
                          widget.user.userType == "admin" ? Text(
                            'Admin',
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ) : widget.user.userType == "dormitoryOwner" ? Text(
                            'Dormitory Owner',
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ) : Text(
                            'Student',
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Divider(color: Colors.grey.shade300),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.phone, size: 16, color: Colors.grey),
                          SizedBox(width: 5),
                          Text(
                            "${widget.user.phoneNo}",
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.email, size: 16, color: Colors.grey),
                          SizedBox(width: 5),
                          Text(
                            "${widget.user.email}",
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Form(
                  key: _formKey,
                  child: Expanded(
                    child: Card(
                      color: Colors.white,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Container(
                        height: 515,
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Edit Profile',
                              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 20),
                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    validator: (v){
                                      if(v!.isEmpty){
                                        return "Field is required";
                                      }else{
                                        return null;
                                      }
                                    },
                                    controller: nameController,
                                    decoration: InputDecoration(
                                      labelText: 'First Name',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 16),
                                Expanded(
                                  child: TextFormField(
                                    validator: (v){
                                      if(v!.isEmpty){
                                        return "Field is required";
                                      }else{
                                        return null;
                                      }
                                    },
                                    controller: surnameController,
                                    decoration: InputDecoration(
                                      labelText: 'Last Name',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            TextFormField(
                              validator: (v){
                                if(v!.isEmpty){
                                  return "Field is required";
                                }else{
                                  return null;
                                }
                              },
                              controller: emailController,
                              decoration: InputDecoration(
                                labelText: 'Email',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: DropdownButtonFormField<String>(
                                    decoration: InputDecoration(
                                      labelText: 'Country Code',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    value: '+90',
                                    items: <String>['+90', '+1', '+44', '+49', '+33']
                                        .map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                    },
                                  ),
                                ),
                                SizedBox(width: 16),
                                Expanded(
                                  flex: 3,
                                  child: TextFormField(
                                    validator: (v){
                                      if(v!.isEmpty){
                                        return "Field is required";
                                      }else{
                                        return null;
                                      }
                                    },
                                    controller: phoneController,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                    ],
                                    decoration: InputDecoration(
                                      labelText: 'Phone Number',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            TextFormField(
                              validator: (v){
                                if(v!.isEmpty){
                                  return "Field is required";
                                }else{
                                  return null;
                                }
                              },
                              controller: passwordController,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                labelText: 'Nationality',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              value: 'Turkey',
                              items: <String>['Turkey', 'USA', 'UK', 'Germany', 'France']
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                              },
                            ),
                            SizedBox(height: 30),
                            ElevatedButton(
                              onPressed: isSaving ? null : () {
                                _formKey.currentState!.save();
                                if(_formKey.currentState!.validate()){
                                  updateUser();
                                }
                              },
                              child: isSaving ? ButtonLoading(buttonText: "Saving") : Text('Save'),
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.blue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: EdgeInsets.symmetric(vertical: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
