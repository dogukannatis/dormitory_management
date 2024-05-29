import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dormitory_management/models/users/dormitory_owner.dart';
import 'package:dormitory_management/ui/widgets/custom_app_bar.dart';
import 'package:dormitory_management/ui/widgets/custom_drawer.dart';
import 'package:dormitory_management/viewmodels/user_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../models/users/admin.dart';
import '../../../models/users/student.dart';
import '../../../models/users/user.dart';
import '../../widgets/button_loading.dart';

class EditProfilePage extends ConsumerStatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends ConsumerState<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController surnameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController passwordController;

  bool isSaving = false;
  XFile? image;

  final ImagePicker picker = ImagePicker();


  Future<void> uploadPhoto() async {
    final userManager = ref.read(userManagerProvider.notifier);

    if(image != null){
      var bytes = image!.readAsBytes();

      final formData = FormData.fromMap({
        'name': 'dio',
        'date': DateTime.now().toIso8601String(),
        'file': await MultipartFile.fromFile(image!.path),
      });

      await userManager.uploadPhoto(formData: formData, file: image);
    }

  }




  @override
  void initState() {
    final user = ref.read(userManagerProvider);
    nameController = TextEditingController(text: user!.name);
    surnameController = TextEditingController(text: user.surName);
    emailController = TextEditingController(text: user.email);
    phoneController = TextEditingController(text: user.phoneNo);
    passwordController = TextEditingController();

    super.initState();
  }

  Future<void> updateProfile() async {
    final userManager = ref.read(userManagerProvider.notifier);
    final user = ref.watch(userManagerProvider);
    setState(() {
      isSaving = true;
    });
    if (user is Student) {
      Student? tempUser = Student(
        userId: user?.userId,
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        name: nameController.text.trim(),
        surName: surnameController.text.trim(),
        phoneNo: phoneController.text.trim(),
        dob: user?.dob,
        createdAt: user?.createdAt,
        updatedAt: user?.updatedAt,
        department: (user as Student).department,
        gender: user.gender,
        profileUrl: user.profileUrl,
        isEmailVerified: user.isEmailVerified,
        emergencyContactNo: user.emergencyContactNo,
        address: user.address,
        studentNumber: user.studentNumber,
        userType: user.userType,
      );

      await userManager.updateStudent(user: tempUser);
    } else if (user is DormitoryOwner) {
      DormitoryOwner? tempUser = DormitoryOwner(
        userId: user.userId,
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        name: nameController.text.trim(),
        surName: surnameController.text.trim(),
        phoneNo: phoneController.text.trim(),
        dob: user.dob,
        createdAt: user.createdAt,
        updatedAt: user.updatedAt,
        profileUrl: user.profileUrl,
        isEmailVerified: user.isEmailVerified,
        address: user.address,
        dormitoryId: user.dormitoryId,
        userType: user.userType,
      );

      await userManager.updateDormitoryOwner(user: tempUser);
    } else if (user is Admin) {
      Admin? tempUser = Admin(
        userId: user.userId,
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        name: nameController.text.trim(),
        surName: surnameController.text.trim(),
        phoneNo: phoneController.text.trim(),
        dob: user.dob,
        createdAt: user.createdAt,
        updatedAt: user.updatedAt,
        profileUrl: user.profileUrl,
        isEmailVerified: user.isEmailVerified,
        address: user.address,
        userType: user.userType,
      );

      await userManager.updateAdmin(user: tempUser);
    }

    setState(() {
      isSaving = false;
    });

    const snackBar = SnackBar(
      content: Text('Profile has been saved!'),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userManagerProvider);

    return Scaffold(
      appBar: getCustomAppBar(context),

      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomDrawer(activePage: ActivePages.editProfilePage,),
          SizedBox(width: 16),
          Container(
            width: 280,
            child: Card(
              color: Colors.white,
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    image != null
                        ? CircleAvatar(
                      radius: 100,
                      backgroundImage: NetworkImage(image!.path),
                      backgroundColor: Colors.black,
                    ) : user?.profilePhotoFile != null ?
                    CircleAvatar(
                      radius: 100,
                      backgroundImage: FileImage(File(user!.profilePhotoFile!.path)),
                      backgroundColor: Colors.black,
                    )
                        : const CircleAvatar(
                      radius: 100,
                      backgroundImage: AssetImage('assets/images/login_access.png'),
                      backgroundColor: Colors.black,
                    ),
                    const SizedBox(height: 10),
                    TextButton(
                      onPressed: () async {
                        image = await picker.pickImage(source: ImageSource.gallery);
                        setState(() {});
                        await uploadPhoto();
                      },
                      child: const Text('Upload Profile Photo'),
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
                    Text(
                      user!.name!,
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
                        user.userType == "admin" ? Text(
                          'Admin',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ) : user.userType == "dormitoryOwner" ? Text(
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
                          user.phoneNo!,
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
                          user.email!,
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Form(
              key: _formKey,
              child: Card(
                color: Colors.white,
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
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
                              controller: nameController,
                              validator: (v){
                                if(v!.isEmpty){
                                  return "Field is required";
                                }else{
                                  return null;
                                }
                              },
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
                              controller: surnameController,
                              validator: (v){
                                if(v!.isEmpty){
                                  return "Field is required";
                                }else{
                                  return null;
                                }
                              },
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
                        controller: emailController,
                        validator: (v){
                          if(v!.isEmpty){
                            return "Field is required";
                          }else{
                            return null;
                          }
                        },
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
                               // phoneController.text = newValue!;
                              },
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            flex: 3,
                            child: TextField(
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
                        controller: passwordController,
                        validator: (v){
                          if(v!.isEmpty){
                            return "Field is required";
                          }else{
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          labelText: 'Password',
                          hintText: 'Change Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
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
                        onChanged: (String? newValue) {},
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: () {
                          _formKey.currentState!.save();
                          if(_formKey.currentState!.validate()){
                            updateProfile();
                          }
                        },
                        child: isSaving ? const ButtonLoading(buttonText: "saving",) : Text('Save'),
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
        ],
      ),
    );
  }
}














/*

import 'dart:io';

import 'package:dormitory_management/models/users/dormitory_owner.dart';
import 'package:dormitory_management/ui/widgets/custom_app_bar.dart';
import 'package:dormitory_management/ui/widgets/custom_drawer.dart';
import 'package:dormitory_management/viewmodels/user_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../models/users/admin.dart';
import '../../../models/users/student.dart';
import '../../../models/users/user.dart';
import '../../widgets/button_loading.dart';


class EditProfilePage extends ConsumerStatefulWidget {
  const EditProfilePage({super.key});

  @override
  ConsumerState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends ConsumerState<EditProfilePage> {

  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final surnameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  bool isSaving = false;

  @override
  void initState() {
    final user = ref.read(userManagerProvider);
    nameController.text = user?.name ?? "";
    surnameController.text = user?.surName ?? "";
    emailController.text = user?.email ?? "";
    phoneController.text = user?.phoneNo ?? "";
    super.initState();
  }


  Future<void> updateProfile() async {
    final userManager = ref.read(userManagerProvider.notifier);
    final user = ref.watch(userManagerProvider);
    setState(() {
      isSaving = true;
    });
    if(user is Student){
      Student? tempUser = Student(
        userId: user?.userId,
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        name: nameController.text.trim(),
        surName: surnameController.text.trim(),
        phoneNo: phoneController.text.trim(),
        dob: user?.dob,
        createdAt: user?.createdAt,
        updatedAt: user?.updatedAt,
        department: (user as Student).department,
        gender: user.gender,
        profileUrl: user.profileUrl,
        isEmailVerified: user.isEmailVerified,
        emergencyContactNo: user.emergencyContactNo,
        address: user.address,
        studentNumber: user.studentNumber,
        userType: user.userType,
      );

      await userManager.updateStudent(user: tempUser);
    }else if(user is DormitoryOwner){
      DormitoryOwner? tempUser = DormitoryOwner(
        userId: user.userId,
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        name: nameController.text.trim(),
        surName: surnameController.text.trim(),
        phoneNo: phoneController.text.trim(),
        dob: user.dob,
        createdAt: user.createdAt,
        updatedAt: user.updatedAt,
        profileUrl: user.profileUrl,
        isEmailVerified: user.isEmailVerified,
        address: user.address,
        dormitoryId: user.dormitoryId,
        userType: user.userType,
      );

      await userManager.updateDormitoryOwner(user: tempUser);
    }else if(user is Admin){
      Admin? tempUser = Admin(
        userId: user.userId,
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        name: nameController.text.trim(),
        surName: surnameController.text.trim(),
        phoneNo: phoneController.text.trim(),
        dob: user.dob,
        createdAt: user.createdAt,
        updatedAt: user.updatedAt,
        profileUrl: user.profileUrl,
        isEmailVerified: user.isEmailVerified,
        address: user.address,
        userType: user.userType,
      );

      await userManager.updateAdmin(user: tempUser);
    }


    setState(() {
      isSaving = false;
    });

    const snackBar = SnackBar(
      content: Text('Profile has been saved!'),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  final ImagePicker picker = ImagePicker();
  XFile? image;

  @override
  Widget build(BuildContext context) {

    final user = ref.watch(userManagerProvider);

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
                  image != null ? CircleAvatar(
                        radius: 100,
                        backgroundImage: NetworkImage(image!.path),
                        backgroundColor: Colors.black,
                      ) : const CircleAvatar(
                    radius: 100,
                    backgroundImage: AssetImage('assets/images/login_access.png'),
                    backgroundColor: Colors.black,
                  ),
                      const SizedBox(height: 10),
                      TextButton(
                        onPressed: () async {
                          image = await picker.pickImage(source: ImageSource.gallery);
                          setState(() {

                          });
                        },
                        child: const Text('Upload Profile Photo'),
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
                      Text(
                        user!.name!,
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
                          Text(
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
                            user!.phoneNo!,
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
                            user!.email!,
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 16),
              Form(
                key: _formKey,
                child: Card(
                  color: Colors.white,
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Container(
                    height: 515,
                    width: 400,
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
                                controller: nameController,
                                decoration: InputDecoration(
                                  labelText: 'First Name',
                                  hintText: user.name,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: TextFormField(
                                controller: surnameController,
                                decoration: InputDecoration(
                                  labelText: 'Last Name',
                                  hintText: user.surName,
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
                          controller: emailController,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            hintText: user.email,
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
                                  phoneController.text = newValue!;
                                },
                              ),
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              flex: 3,
                              child: TextField(
                                decoration: InputDecoration(
                                  labelText: 'Phone Number',
                                  hintText: '1111111111',
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
                          controller: passwordController,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            hintText: 'Change Password',
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
                          onPressed: () {
                            updateProfile();
                          },
                          child: isSaving ? ButtonLoading(buttonText: "saving",) : Text('Save'),
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
            ],
          ),
        ),
      ),
    );
  }
}

*/