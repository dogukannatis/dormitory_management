import 'package:dormitory_management/ui/pages/compare_dormitories_page.dart';
import 'package:dormitory_management/ui/pages/dormitory_details_page.dart';
import 'package:dormitory_management/ui/pages/home_page.dart';
import 'package:dormitory_management/ui/pages/signin_page.dart';
import 'package:dormitory_management/ui/pages/signup_page.dart';
import 'package:flutter/material.dart';


class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 4,
      shadowColor: Colors.black,
      backgroundColor: Colors.white,
      title: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.0),
        child: Row(
          children: [
            Icon(Icons.home_filled, size: 30,),
            SizedBox(width: 10,),
            Text("Dorm MGMT", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),)
          ],
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                InkWell(
                  child: const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text("Home"),
                  ),
                  onTap: (){},
                ),
                InkWell(
                  child: const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text("Dormitories"),
                  ),
                  onTap: (){},
                ),
                InkWell(
                  child: const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text("Compare Dormitories"),
                  ),
                  onTap: (){},
                ),
              ],
            ),
            const SizedBox(width: 20,),
            Row(
              children: [
                ElevatedButton(
                  onPressed: (){},
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Sign In"),
                  ),
                ),
                const SizedBox(width: 10,),
                ElevatedButton(
                  onPressed: (){},
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Sign Up"),
                  ),
                )
              ],
            )
          ],
        ),
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => throw UnimplementedError();
}


AppBar getCustomAppBar(BuildContext context) {
  return AppBar(
    elevation: 4,
    shadowColor: Colors.black,
    backgroundColor: Colors.white,
    title: const Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.0),
      child: Row(
        children: [
          Icon(Icons.home_filled, size: 30,),
          SizedBox(width: 10,),
          Text("Dorm MGMT", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),)
        ],
      ),
    ),
    actions: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              InkWell(
                child: const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text("Home"),
                ),
                onTap: (){
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const HomePage()));
                },
              ),
              InkWell(
                child: const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text("Compare Dormitories"),
                ),
                onTap: (){
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const CompareDormitoriesPage()));
                },
              ),
            ],
          ),
          const SizedBox(width: 20,),
          Row(
            children: [
              ElevatedButton(
                onPressed: (){
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const SigninPage()));
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Sign In"),
                ),
              ),
              const SizedBox(width: 10,),
              ElevatedButton(
                onPressed: (){
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const SignupPage()));
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Sign Up"),
                ),
              )
            ],
          )
        ],
      ),
    ],
  );
}