
import 'package:dormitory_management/ui/pages/home_page.dart';
import 'package:dormitory_management/ui/pages/signup_page.dart';
import 'package:dormitory_management/ui/widgets/custom_app_bar.dart';
import 'package:dormitory_management/viewmodels/user_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class SignInPage extends ConsumerStatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  ConsumerState createState() => _SignInPageState();
}

class _SignInPageState extends ConsumerState<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();


  Future<void> login(String email, String password) async {
    final userManager = ref.read(userManagerProvider.notifier);
    try{
      await userManager.login(email: email, password: password);
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const HomePage()));
    }catch(e,str){
        debugPrint("ERROR: $e $str");
    }
  }




  @override
  Widget build(BuildContext context) {
    ref.watch(userManagerProvider);

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
                        "Welcome back!",
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Please enter your details.",
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                      const SizedBox(height: 15),
                      buildLoginFormContent(),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              "Forgot Password",
                              style: TextStyle(fontSize: 14, color: Colors.black),
                            ),
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
                          onPressed: () {
                            _formKey.currentState!.save();
                            if(_formKey.currentState!.validate()){
                              login(emailController.text.trim(), passwordController.text.trim());
                            }
                          },
                          child: const Text(
                            "Log in",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don't have an account?",
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                          const SizedBox(width: 5),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SignupPage()));
                            },
                            child: const Text(
                              "Sign up for free",
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



  Widget buildLoginFormContent() {
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
            child: TextFormField(
              controller: emailController,
              validator: (v){
                if(v!.isEmpty){
                  return "Email is required";
                }else{
                  return null;
                }
              },
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
            child: TextFormField(
              controller: passwordController,
              obscureText: true,
              validator: (v){
                if(v!.isEmpty){
                  return "Password is required";
                }else{
                  return null;
                }
              },
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