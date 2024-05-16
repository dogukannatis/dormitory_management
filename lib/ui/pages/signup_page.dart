import 'package:dormitory_management/ui/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool _acceptTerms = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
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
                          Text(
                            "I accept the Terms & Conditions",
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Container(
                        width: 350,
                        height: 50,
                        margin: EdgeInsets.symmetric(horizontal: 30),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            "Sign up",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
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
    return Column(
      children: [
        Container(
          height: 50,
          width: 350,
          margin: EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: TextField(
            decoration: InputDecoration(
              hintText: "Name",
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 16),
            ),
          ),
        ),
        Container(
          height: 50,
          width: 350,
          margin: EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: TextField(
            decoration: InputDecoration(
              hintText: "Surname",
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 16),
            ),
          ),
        ),
        Container(
          height: 50,
          width: 350,
          margin: EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: TextField(
            decoration: InputDecoration(
              hintText: "Phone Number",
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 16),
            ),
          ),
        ),
        Container(
          height: 50,
          width: 350,
          margin: EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: TextField(
            decoration: InputDecoration(
              hintText: "Email",
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 16),
            ),
          ),
        ),
        Container(
          height: 50,
          width: 350,
          margin: EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: TextField(
            obscureText: true,
            decoration: InputDecoration(
              hintText: "Password",
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 16),
            ),
          ),
        ),
      ],
    );
  }
}