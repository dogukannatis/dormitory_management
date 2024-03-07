import 'package:flutter/material.dart';

class TopMenu extends StatefulWidget {
  const TopMenu({super.key});

  @override
  State<TopMenu> createState() => _TopMenuState();
}

class _TopMenuState extends State<TopMenu> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.0),
          child: Row(
            children: [
              Icon(Icons.home_filled, size: 30,),
              Text("Dorm MGMT", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),)
            ],
          ),
        ),
        const SizedBox(width: 20,),
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
        )
      ],
    );
  }
}
