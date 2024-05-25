import 'package:dormitory_management/models/dormitory_details.dart';
import 'package:dormitory_management/ui/widgets/custom_app_bar.dart';
import 'package:dormitory_management/ui/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';

class DormitoryDetailsPage extends StatefulWidget {
  const DormitoryDetailsPage({Key? key, required this.details}) : super(key: key);

  final DormitoryDetails details;

  @override
  State<DormitoryDetailsPage> createState() => _DormitoryDetailsPageState();
}

class _DormitoryDetailsPageState extends State<DormitoryDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: getCustomAppBar(context),
      drawer: const CustomDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Column(
            children: [
              Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 50.0),
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(15.0),
                              bottomLeft: Radius.circular(15.0),
                            ),
                            child: Image.asset(
                              'assets/images/home_img1.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Universe Dormitory',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Text(
                                'About',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                              textAlign: TextAlign.justify,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Text(
                                'Features',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            SizedBox(height: 16),
                            Wrap(
                              spacing: 8,
                              runSpacing: 4,
                              children: [
                                Chip(
                                  label: Text('Clean Service'),
                                  backgroundColor: Colors.green[100],
                                ),
                                Chip(
                                  label: Text('TV'),
                                  backgroundColor: Colors.green[100],
                                ),
                                Chip(
                                  label: Text('AC'),
                                  backgroundColor: Colors.green[100],
                                ),
                                Chip(
                                  label: Text('Shower'),
                                  backgroundColor: Colors.green[100],
                                ),
                                Chip(
                                  label: Text('Internet'),
                                  backgroundColor: Colors.green[100],
                                ),
                                Chip(
                                  label: Text('Kitchen'),
                                  backgroundColor: Colors.red[100],
                                ),
                                Chip(
                                  label: Text('Balcony'),
                                  backgroundColor: Colors.red[100],
                                ),
                                Chip(
                                  label: Text('Microwave'),
                                  backgroundColor: Colors.green[100],
                                ),
                              ],
                            ),
                            SizedBox(height: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'TRY 90.000',
                                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8),
                                ElevatedButton(
                                  onPressed: () {},
                                  child: Text('Book Now'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 50),
              Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Comments',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 50),
                      CommentWidget(
                        username: 'Utku Eren Yalçın',
                        timeAgo: '2 days ago',
                        comment: 'super dorm',
                      ),
                      SizedBox(height: 50),
                      TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Write a review',
                        ),
                        maxLines: 3,
                      ),
                      SizedBox(height: 50),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text('Submit Review'),
                      ),
                    ],
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

class CommentWidget extends StatelessWidget {
  final String username;
  final String timeAgo;
  final String comment;

  CommentWidget({
    required this.username,
    required this.timeAgo,
    required this.comment,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          child: Icon(Icons.person),
        ),
        SizedBox(width: 50),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(username, style: TextStyle(fontWeight: FontWeight.bold)),
              Text(timeAgo, style: TextStyle(color: Colors.grey)),
              Text(comment),
            ],
          ),
        ),
      ],
    );
  }
}
