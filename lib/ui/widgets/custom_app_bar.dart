import 'package:dormitory_management/ui/pages/compare_dormitories_page.dart';
import 'package:dormitory_management/ui/pages/dormitory_details_page.dart';
import 'package:dormitory_management/ui/pages/home_page.dart';
import 'package:dormitory_management/ui/pages/signin_page.dart';
import 'package:dormitory_management/ui/pages/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../viewmodels/user_manager.dart';


class CustomAppBar extends ConsumerStatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  ConsumerState createState() => _CustomAppBarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => throw UnimplementedError();
}

class _CustomAppBarState extends ConsumerState<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userManagerProvider);
    final userManager = ref.read(userManagerProvider.notifier);

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
            user == null ?
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
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const SignInPage()));
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
            ) :  ElevatedButton(
              onPressed: (){
                userManager.signOut();
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Sign Out"),
              ),
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
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const SignInPage()));
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
