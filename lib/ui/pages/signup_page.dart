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
              color: Color(0xFFF5F5F5),
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
                  padding: EdgeInsets.all(24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Welcome!",
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Please enter your details for signing up!",
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                      SizedBox(height: 15),
                      buildSignupFormContent(),
                      SizedBox(height: 15),
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
                                department: "", // eklenecek
                                gender: "", // eklenecek
                                profileUrl: "null",
                                isEmailVerified: false,
                                emergencyContactNo: "", // eklenecek
                                address: "", // eklenecek
                                studentNumber: "", // eklenecek
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
                          Text(
                            "Do you have an account?",
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                          SizedBox(width: 5),
                          TextButton(
                            onPressed: () {},
                            child: Text(
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
      child: Column(
        children: [
          Container(
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
            child: TextField(
              controller: nameController,
              decoration: const InputDecoration(
                hintText: "Name",
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 16),
              ),
            ),
          ),
          Container(
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
            child: TextField(
              controller: surnameController,
              decoration: const InputDecoration(
                hintText: "Surname",
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 16),
              ),
            ),
          ),
          Container(
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
            child: TextField(
              controller: phoneController,
              decoration: const InputDecoration(
                hintText: "Phone Number",
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 16),
              ),
            ),
          ),
          Container(
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
            child: TextField(
              controller: emailController,
              decoration: const InputDecoration(
                hintText: "Email",
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 16),
              ),
            ),
          ),
          Container(
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
            child: TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: "Password",
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}