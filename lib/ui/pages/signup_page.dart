import 'package:dormitory_management/models/users/student.dart';
import 'package:dormitory_management/ui/pages/signin_page.dart';
import 'package:dormitory_management/ui/widgets/custom_app_bar.dart';
import 'package:dormitory_management/viewmodels/user_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignupPage extends ConsumerStatefulWidget {
  const SignupPage({super.key});

  @override
  ConsumerState createState() => _SignupPageState();
}

class _SignupPageState extends ConsumerState<SignupPage> {

  bool _acceptTerms = false;

  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final surnameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final departmentController = TextEditingController();
  final genderController = TextEditingController();
  final emergencyContactNoController = TextEditingController();
  final addressController = TextEditingController();
  final studentNumberController = TextEditingController();

  Future<void> register({required Student student}) async {
    final userManager = ref.read(userManagerProvider.notifier);
    await userManager.saveStudent(user: student);
    const snackBar = SnackBar(
      content: Text('Account has been created!'),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    setState(() {
      nameController.clear();
      surnameController.clear();
      phoneController.clear();
      emailController.clear();
      passwordController.clear();
      departmentController.clear();
      genderController.clear();
      emergencyContactNoController.clear();
      addressController.clear();
      studentNumberController.clear();
    });

    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const SignInPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: getCustomAppBar(context),
      body: SafeArea(
        child: Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 2,
              color: const Color(0xFFF5F5F5),
              child: Center(
                child: Image.asset(
                  'assets/images/login_access.png',
                  width: MediaQuery.of(context).size.width / 3,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Welcome!",
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Please enter your details for signing up!",
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                      const SizedBox(height: 15),
                      buildSignupFormContent(),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Checkbox(
                            value: _acceptTerms,
                            onChanged: (value) {
                              setState(() {
                                _acceptTerms = value!;
                              });
                            },
                          ),
                          const Text(
                            "I accept the Terms & Conditions",
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Container(
                        width: 350,
                        height: 50,
                        margin: const EdgeInsets.symmetric(horizontal: 30),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: TextButton(
                          onPressed: _acceptTerms == true ? () {
                            _formKey.currentState!.save();
                            if(_formKey.currentState!.validate()){
                              Student student = Student(
                                userId: null,
                                email: emailController.text.trim(),
                                password: passwordController.text.trim(),
                                name: nameController.text.trim(),
                                surName: surnameController.text.trim(),
                                phoneNo: phoneController.text.trim(),
                                dob: DateTime.now(),
                                createdAt: DateTime.now(),
                                updatedAt: DateTime.now(),
                                department: departmentController.text.trim(),
                                gender: genderController.text.trim(),
                                profileUrl: "null",
                                isEmailVerified: false,
                                emergencyContactNo: emergencyContactNoController.text.trim(),
                                address: addressController.text.trim(),
                                studentNumber: studentNumberController.text.trim(),
                                userType: "student",
                              );
                              register(student: student);
                            }

                          } : null,
                          child: const Text(
                            "Sign up",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Do you have an account?",
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                          const SizedBox(width: 5),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SignInPage()));
                            },
                            child: const Text(
                              "Log in",
                              style: TextStyle(fontSize: 14, color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSignupFormContent() {
    return Form(
      key: _formKey,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              buildTextFormField(nameController, "Name", "Name is required"),
              buildTextFormField(surnameController, "Surname", "Surname is required"),
              buildTextFormField(phoneController, "Phone Number", "Phone number is required"),
              buildTextFormField(emailController, "Email", "Email is required"),
              buildTextFormField(passwordController, "Password", "Password is required", obscureText: true),
            ],
          ),
          const SizedBox(width: 20),
          Column(
            children: [
              buildTextFormField(departmentController, "Department", "Department is required"),
              buildTextFormField(genderController, "Gender", "Gender is required"),
              buildTextFormField(emergencyContactNoController, "Emergency Contact No", "Emergency contact number is required"),
              buildTextFormField(addressController, "Address", "Address is required"),
              buildTextFormField(studentNumberController, "Student Number", "Student number is required"),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildTextFormField(TextEditingController controller, String hintText, String validationMessage, {bool obscureText = false}) {
    return Container(
      height: 50,
      width: 350,
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        validator: (v) {
          if (v!.isEmpty) {
            return validationMessage;
          }
          return null;
        },
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        ),
      ),
    );
  }
}
