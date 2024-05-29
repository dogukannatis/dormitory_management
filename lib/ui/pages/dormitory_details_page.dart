import 'package:dormitory_management/models/booking.dart';
import 'package:dormitory_management/models/dormitory_details.dart';
import 'package:dormitory_management/models/users/dormitory_owner.dart';
import 'package:dormitory_management/models/users/student.dart';
import 'package:dormitory_management/ui/widgets/button_loading.dart';
import 'package:dormitory_management/ui/widgets/custom_app_bar.dart';
import 'package:dormitory_management/ui/widgets/custom_drawer.dart';
import 'package:dormitory_management/viewmodels/booking_manager.dart';
import 'package:dormitory_management/viewmodels/comment_manager.dart';
import 'package:dormitory_management/viewmodels/dorm_manager.dart';
import 'package:dormitory_management/viewmodels/user_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../models/comment.dart';
import '../../models/dormitory.dart';
import '../../models/rating.dart';
import '../../models/room.dart';
import '../../models/users/admin.dart';

class DormitoryDetailsPage extends ConsumerStatefulWidget {
  const DormitoryDetailsPage({Key? key, required this.dormitory}) : super(key: key);

  final Dormitory dormitory;

  @override
  ConsumerState createState() => _DormitoryDetailsPageState();
}

class _DormitoryDetailsPageState extends ConsumerState<DormitoryDetailsPage> {

  bool isBooked = false;

  Future<void> book({required int roomId}) async {
    final bookingManager = ref.read(bookingManagerProvider.notifier);
    final user = ref.watch(userManagerProvider);
    Booking booking = Booking(
        bookingId: null,
        userId: user!.userId,
        dormitoryId: widget.dormitory.dormitoryId,
        status: "pending",
      paymentStatus: "pending",
        roomId: roomId,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      inMin: DateTime.now(),
      inMax: DateTime.now(),
      outMin: DateTime.now(),
      outMax: DateTime.now(),
    );
    setState(() {
      isBooked = true;
    });
    await bookingManager.saveBooking(booking: booking);
  }

  bool isLoading = false;

  final scrollController = ScrollController();

  List<Room> rooms = [];

  Future<void> saveComment() async {
    final commentManager = ref.read(commentManagerProvider.notifier);
    final user = ref.watch(userManagerProvider);
    Comment comment = Comment(
        commentId: null,
        userId: user!.userId,
        dormitoryId: widget.dormitory.dormitoryId,
      commentContent: commentController.text.trim(),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    comment.user = user;
    setState(() {
      isLoading = true;
    });
    await commentManager.saveComment(comment: comment);
    commentController.clear();
    widget.dormitory.comments!.add(comment);
    setState(() {
      isLoading = false;
    });
  }

  Future<void> deleteComment(int commentId) async {
    final commentManager = ref.read(commentManagerProvider.notifier);
    setState(() {
      widget.dormitory.comments!.removeWhere((comment) => comment!.commentId == commentId);
    });
    await commentManager.deleteCommentByID(commentId: commentId);
  }

  Future<void> getRooms() async {
    final dormManager = ref.read(dormManagerProvider.notifier);
    rooms = await dormManager.getRoomByDormitoryId(dormitoryId: widget.dormitory.dormitoryId!);
    setState(() {

    });
  }

  @override
  void initState() {
    getRooms();
    super.initState();
  }

  bool canSendRate = true;

  final _formKey = GlobalKey<FormState>();
  final commentController = TextEditingController();

  Future<void> sendRate(int rate) async {
    final dormManager = ref.read(dormManagerProvider.notifier);
    final user = ref.read(userManagerProvider);
    Rating rating = Rating(
        ratingId: null,
        dormitoryId: widget.dormitory.dormitoryId,
        userId: user!.userId,
        ratingNo: rate,
        review: "",
        createdAt: DateTime.now(),
        updatedAt: DateTime.now()
    );
    await dormManager.saveRate(rating: rating);
  }


  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userManagerProvider);
    ref.watch(dormManagerProvider);

    if(user == null){
      canSendRate = false;
    }

    double rate = 0.0;

    if (widget.dormitory.ratings != null) {
      for (Rating rating in widget.dormitory.ratings!) {
        rate += rating.ratingNo!;
      }
      if (rate != 0) {
        rate /= widget.dormitory.ratings!.length;
      }
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: getCustomAppBar(context),
      drawer: const CustomDrawer(),
      body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
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
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        rooms.isNotEmpty ?
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(50.0),
                              child: Column(
                                children: [
                                  SizedBox(
                                    width: double.infinity,
                                    height: 200,
                                    child: ListView.builder(
                                      controller: scrollController,
                                      itemCount: rooms.length,
                                      scrollDirection: Axis.horizontal,
                                      physics: BouncingScrollPhysics(),
                                      itemBuilder: (context, index){
                                        return SizedBox(
                                          height: 200,
                                          width: 200,
                                          child: Card(
                                            color: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(15.0),
                                            ),
                                            elevation: 5,
                                            child: Padding(
                                              padding: const EdgeInsets.all(16.0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  const Text("Room", style: TextStyle(fontSize: 24 ,fontWeight: FontWeight.bold),),
                                                  SizedBox(height: 10,),
                                                  Text("Room Type: ${rooms[index].roomType!}"),
                                                  SizedBox(height: 10,),
                                                  Text("${rooms[index].price}₺"),
                                                  SizedBox(height: 10,),
                                                  ElevatedButton(
                                                    onPressed: !(user != null && user is Student) || isBooked ? null : () => book(roomId: rooms[index].roomId!),
                                                    child: isBooked ? const Text("Booked") : const Text('Book Now'),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ) : Container(),

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
                                  'Rate Dorm',
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 10),
                                RatingBar.builder(
                                  initialRating: rate,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  ignoreGestures: !canSendRate,
                                  itemCount: 5,
                                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                  itemBuilder: (context, _) => Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  onRatingUpdate: (rating) {
                                    rate += rating;
                                    if (rate != 0) {
                                      rate /= widget.dormitory.ratings!.length + 1;
                                    }
                                    setState(() {
                                      canSendRate = false;
                                    });
                                    sendRate(rating.toInt());
                                  },
                                ),

                              SizedBox(height: 10),
                                Text(
                                  'Comments',
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 30),
                                widget.dormitory.comments != null && widget.dormitory.comments!.isNotEmpty ?
                                ListView.builder(
                                  itemCount: widget.dormitory.comments!.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index){
                                    Comment? comment = widget.dormitory.comments![index];
                                    debugPrint("comment: $comment");
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: CommentWidget(
                                        username: comment!.user!.name!,
                                        timeAgo: timeago.format(comment.createdAt!),
                                        comment: comment.commentContent!,
                                        onPressed: (){
                                          deleteComment(comment.commentId!);
                                        },
                                        canDelete: user is Admin ||
                                        (user is DormitoryOwner && user.dormitoryId == comment.dormitoryId)
                                            || comment.user!.userId == user?.userId ? true : false,
                                      ),
                                    );
                                  },
                                ) : Center(
                                  child: Text("There is no comment yet."),
                                ),
                                SizedBox(height: 50),
                                user == null ? Center(
                                  child: Text("Please sign in to write a comment."),
                                ) :
                                user is Student ?
                                    Form(
                                      key: _formKey,
                                      child: Column(
                                        children: [
                                           TextFormField(
                                             controller: commentController,
                                            validator: (v){
                                               if(v!.isEmpty){
                                                 return "Field is required";
                                               }else{
                                                 return null;
                                               }
                                            },
                                            decoration: const InputDecoration(
                                              border: OutlineInputBorder(),
                                              labelText: 'Write a review',
                                            ),
                                            maxLines: 3,
                                          ),
                                          const SizedBox(height: 50),
                                          ElevatedButton(
                                            onPressed: isLoading ? null : () {
                                              _formKey.currentState!.save();
                                              if(_formKey.currentState!.validate()){
                                                saveComment();
                                              }
                                            },
                                            child: isLoading ? ButtonLoading(buttonText: "Submit Review") : const Text('Submit Review'),
                                          ),
                                        ],
                                      ),
                                    ) : Center(
                                  child: Text("Please sign in as a Student to write a comment."),
                                ),

                              ],
                            ),
                          ),
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
  final bool canDelete;
  final Function()? onPressed;

  CommentWidget({
    required this.username,
    required this.timeAgo,
    required this.comment,
    required this.onPressed,
    this.canDelete = false,
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
        canDelete ?
        IconButton(
          onPressed: onPressed,
          icon: const Icon(Icons.delete, color: Colors.red,),
        ) : Container()
      ],
    );
  }
}
