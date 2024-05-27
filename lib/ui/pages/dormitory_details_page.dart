import 'package:dormitory_management/models/booking.dart';
import 'package:dormitory_management/models/dormitory_details.dart';
import 'package:dormitory_management/ui/widgets/custom_app_bar.dart';
import 'package:dormitory_management/ui/widgets/custom_drawer.dart';
import 'package:dormitory_management/viewmodels/booking_manager.dart';
import 'package:dormitory_management/viewmodels/dorm_manager.dart';
import 'package:dormitory_management/viewmodels/user_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/comment.dart';
import '../../models/dormitory.dart';

class DormitoryDetailsPage extends ConsumerStatefulWidget {
  const DormitoryDetailsPage({Key? key, required this.dormitory}) : super(key: key);

  final Dormitory dormitory;

  @override
  ConsumerState createState() => _DormitoryDetailsPageState();
}

class _DormitoryDetailsPageState extends ConsumerState<DormitoryDetailsPage> {

  Future<void> book() async {
    final bookingManager = ref.read(bookingManagerProvider.notifier);
    final user = ref.watch(userManagerProvider);
    Booking booking = Booking(
        bookingId: null,
        userId: user!.userId,
        dormitoryId: widget.dormitory.dormitoryId,
        status: "pending",
        roomId: 0 //TODO: check
    );
    await bookingManager.saveDormitory(booking: booking);
  }

  Future<void> getComments() async {
    final dormManager = ref.read(dormManagerProvider.notifier);
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userManagerProvider);


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
                              widget.dormitory.name!,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.0),
                              child: Text(
                                "Description",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              widget.dormitory.dormitoryDetails!.description!,
                              textAlign: TextAlign.justify,
                            ),
                            const Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Text(
                                'Features',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            getFeatures(),
                            const SizedBox(height: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                /*
                                Row(
                                  children: [
                                    Text(
                                      'TRY 90.000',
                                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8),
                                 */
                                ElevatedButton(
                                  onPressed: user == null ? null : () => book(),
                                  child: const Text('Book Now'),
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
              const SizedBox(height: 50),

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
                      ListView.builder(
                        itemCount: widget.dormitory.comments!.length,
                        itemBuilder: (context, index){
                          Comment? comment = widget.dormitory.comments![index];
                          return CommentWidget(
                          username: comment!.user!.name!,
                          timeAgo: '2 days ago',
                          comment: comment.commentContent!,
                          );
                        },
                      ),
                      SizedBox(height: 50),
                      user != null ?
                          Column(
                            children: [
                              const TextField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Write a review',
                                ),
                                maxLines: 3,
                              ),
                              const SizedBox(height: 50),
                              ElevatedButton(
                                onPressed: () {},
                                child: const Text('Submit Review'),
                              ),
                            ],
                          ) : Container(),

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

  Wrap getFeatures() {
    return Wrap(
      spacing: 8,
      runSpacing: 4,
      children: [
        Chip(
          label: Text('Clean Service'),
          backgroundColor: widget.dormitory.dormitoryDetails!.hasCleanService == true ? Colors.green[100] : Colors.red[100],
        ),
        Chip(
          label: Text('TV'),
          backgroundColor: widget.dormitory.dormitoryDetails!.hasTV == true ? Colors.green[100] : Colors.red[100],
        ),
        Chip(
          label: Text('AC'),
          backgroundColor: widget.dormitory.dormitoryDetails!.hasAirConditioning == true ? Colors.green[100] : Colors.red[100],
        ),
        Chip(
          label: Text('Shower'),
          backgroundColor: widget.dormitory.dormitoryDetails!.hasShowerAndToilet == true ? Colors.green[100] : Colors.red[100],
        ),
        Chip(
          label: Text('Internet'),
          backgroundColor: widget.dormitory.dormitoryDetails!.internetSpeed == true ? Colors.green[100] : Colors.red[100],
        ),
        Chip(
          label: Text('Kitchen'),
          backgroundColor: widget.dormitory.dormitoryDetails!.hasKitchen == true ? Colors.green[100] : Colors.red[100],
        ),
        Chip(
          label: Text('Balcony'),
          backgroundColor: widget.dormitory.dormitoryDetails!.hasBalcony == true ? Colors.green[100] : Colors.red[100],
        ),
        Chip(
          label: Text('Microwave'),
          backgroundColor: widget.dormitory.dormitoryDetails!.hasMicrowave == true ? Colors.green[100] : Colors.red[100],
        ),
      ],
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
