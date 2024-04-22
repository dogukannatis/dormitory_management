

import 'package:dormitory_management/models/app_notification.dart';
import 'package:dormitory_management/models/booking.dart';
import 'package:dormitory_management/models/comment.dart';
import 'package:dormitory_management/models/dormitory.dart';
import 'package:dormitory_management/models/dormitory_details.dart';
import 'package:dormitory_management/models/rating.dart';
import 'package:dormitory_management/models/users/admin.dart';
import 'package:dormitory_management/models/users/dormitory_owner.dart';
import 'package:dormitory_management/models/users/student.dart';
import 'package:dormitory_management/services/admin_api.dart';
import 'package:dormitory_management/services/booking_api.dart';
import 'package:dormitory_management/services/comment_api.dart';
import 'package:dormitory_management/services/dormitory_api.dart';
import 'package:dormitory_management/services/dormitory_details.dart';
import 'package:dormitory_management/services/dormitory_owner_api.dart';
import 'package:dormitory_management/services/notification_api.dart';
import 'package:dormitory_management/services/rating_api.dart';
import 'package:dormitory_management/services/student_api.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  final api = StudentApi();

  final adminApi = AdminApi();

  final bookingApi = BookingApi();

  final commentApi = CommentApi();

  final dormitoryApi = DormitoryApi();

  final dormitoryDetailsApi = DormitoryDetailsApi();

  final dormitoryOwnerApi = DormitoryOwnerApi();

  final notificationApi = NotificationApi();

  final ratingApi = RatingApi();

  Student testUser = Student(
      userId: 7,
      name: "asf",
      surName: "cukk",
      email: "test@mgmt.com",
      phoneNo: "01020304056",
      dob: DateTime.now(),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      studentNumber: "1900",
      address: "kıbrıs",
      password: "123",
      department: "it",
      gender: "erkek",
      profileUrl: "null",
      isEmailVerified: false,
      emergencyContactNo: "123"
    );

    Admin testAdmin = Admin(
      userId: null,
      name: "Test User zort",
      surName: "cukk",
      email: "test@mgmt.com",
      phoneNo: "01020304056",
      dob: DateTime.now(),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      address: "kıbrıs",
      password: "123", 
      profileUrl: "null",

  
    );

    DormitoryOwner testDormitoryOwner = DormitoryOwner(
      userId: null,
      name: "Test Dorm Owner",
      surName: "user",
      dormitoryId: 1,
      email: "dorm@owner.com",
      phoneNo: "01020304056",
      dob: DateTime.now(),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      address: "kıbrıs",
      password: "123", 
      profileUrl: "null",
      isEmailVerified: true,
    );

    Booking testBooking = Booking(
      bookingId: 2,
      userId: 1,
      dormitoryId: 2, 
      roomId: 8,
      status: "Pending",
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    Comment testComment = Comment(
      commentId: 2,
      userId: 1,
      dormitoryId: 1,
      commentContent: "pırt",
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    Dormitory testDormitory = Dormitory(
      dormitoryId: 2,
      universityId: 1,
      name: "emu sa",
      quota: 10,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    DormitoryDetails testDormitoryDetails = DormitoryDetails(
      detailId: 2,
      dormitoryId: 1,
      contactNo: "12366999",
      email: "dorm@mail.com",
      faxNo: "123",
      address: "dasd",
      capacity: 100,
      description: "a test dorm details",
      internetSpeed: "10mbps",
      hasKitchen: true,
      hasCleanService: true,
      hasShowerAndToilet: true,
      hasBalcony: false,
      hasTV: true,
      hasAirConditioning: true,
      hasMicrowave: false,
      photoUrls: ["photo1","photo2"],
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    

    AppNotification testNotification = AppNotification(
      id: 2, 
      title: "test2",
      description: "test notification",
      senderId: 1,
      receiverId: 2,
      seen: true,
      imageUrl: "as",
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    Rating testRating = Rating(
      id: null,
      userId: 1,
      dormitoryId: 1,
      ratingNo: 5,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

  test('Student Save', () async {
    expect(await api.saveStudent(user: testUser), equals("99"));
  });


  test('Get Student By ID', () async {
    expect(await api.getStudentByID(id: 3), equals("99"));
  });



  test('Get all students', () async {
    expect(await api.getAllStudents(), equals("99"));
  });

  test('Update student', () async {
    expect(await api.updateStudent(user: testUser), equals("99"));
  });

  test('get user by name', () async {
    expect(await api.getStudentByName(name: "dodo"), equals("99"));
  });


  test('viewStudentProfileInfo', () async {
    expect(await api.viewStudentProfileInfo(id: 7), equals("99"));
  });

  test('getNotificationByStudentId', () async {
    expect(await api.getNotificationByStudentId(id: 7), equals("99"));
  });


// admin test


  test('getAllAdmins', () async {
    expect(await adminApi.getAllAdmins(), equals([]));
  });

  
  test('saveAdmin', () async {
    expect(await adminApi.saveAdmin(user: testAdmin), equals(true));
  });

  test('getAdminByID', () async {
    expect(await adminApi.getAdminByID(id: 1), equals(true));
  });


  test('saveBooking', () async {
    expect(await bookingApi.saveBooking(booking: testBooking), equals(true));
  });

  test('getBookingByID', () async {
    expect(await bookingApi.getBookingByID(id: 1), equals(true));
  });

  test('getBookingHistoryByStudentId', () async {
    expect(await bookingApi.getBookingHistoryByStudentId(userId: 1), equals(true));
  });


  test('getAllBookings', () async {
    expect(await bookingApi.getAllBookings(), equals(true));
  });


  test('deleteStudentByID', () async {
    expect(await bookingApi.deleteStudentByID(bookingId: 3), equals(true));
  });

  test('updateBooking', () async {
    expect(await bookingApi.updateBooking(booking: testBooking), equals(true));
  });


// comment test

  test('saveComment', () async {
    expect(await commentApi.saveComment(comment: testComment), equals(true));
  });


   test('getCommentByID', () async {
    expect(await commentApi.getCommentByID(commentId: 1), equals(true));
  });


  test('getAllComments', () async {
    expect(await commentApi.getAllComments(), equals(true));
  });


  test('deleteCommentByID', () async {
    expect(await commentApi.deleteCommentByID(commentId: 1), equals(true));
  });

  test('updateBooking', () async {
    expect(await commentApi.updateBooking(comment: testComment), equals(true));
  });


// comment test

  test('saveDormitory', () async {
    expect(await dormitoryApi.saveDormitory(dormitory: testDormitory), equals(true));
  });


  test('getDormitoryByID', () async {
    expect(await dormitoryApi.getDormitoryByID(dormitroyId: 1), equals(true));
  });


  test('getAllDormitories', () async {
    expect(await dormitoryApi.getAllDormitories(), equals(true));
  });



  test('deleteDormitoryByID', () async {
    expect(await dormitoryApi.deleteDormitoryByID(dormitoryId: 1), equals(true));
  });


  test('updateDormitory', () async {
    expect(await dormitoryApi.updateDormitory(dormitory: testDormitory), equals(true));
  });

// comment test

  test('saveDormitoryDetails', () async {
    expect(await dormitoryDetailsApi.saveDormitoryDetails(dormitoryDetails: testDormitoryDetails), equals(true));
  });


  test('getDormitoryDetailsByID', () async {
    expect(await dormitoryDetailsApi.getDormitoryDetailsByID(dormitoryDetailsId: 1), equals(true));
  });

  test('deleteDormitoryDetailsByID', () async {
    expect(await dormitoryDetailsApi.deleteDormitoryDetailsByID(dormitoryDetailsId: 1), equals(true));
  });

   test('updateDormitoryDetails', () async {
    expect(await dormitoryDetailsApi.updateDormitoryDetails(dormitoryDetails: testDormitoryDetails), equals(true));
  });


// dormitory owner user test (test edilmedi)

  test('saveDormitoryOwner', () async {
    expect(await dormitoryOwnerApi.saveDormitoryOwner(user: testDormitoryOwner), equals(true));
  });

  test('getAllDormitoryOwners', () async {
    expect(await dormitoryOwnerApi.getAllDormitoryOwners(), equals(true));
  });

  test('deleteDormitoryOwnerByID', () async {
    expect(await dormitoryOwnerApi.deleteDormitoryOwnerByID(id: 1), equals(true));
  });

  test('updateDormitoryOwner', () async {
    expect(await dormitoryOwnerApi.updateDormitoryOwner(user: testDormitoryOwner), equals(true));
  });

  test('getDormitoryOwnerByID', () async {
    expect(await dormitoryOwnerApi.getDormitoryOwnerByID(id: 1), equals(true));
  });

   test('getPendingBookingsForDormitory', () async {
    expect(await dormitoryOwnerApi.getPendingBookingsForDormitory(dormId: 1), equals(true));
  });

   test('getallBookingsForDormitory', () async {
    expect(await dormitoryOwnerApi.getallBookingsForDormitory(dormId: 1), equals(true));
  });

   test('approveStudentsBookingRequest', () async {
    expect(await dormitoryOwnerApi.approveStudentsBookingRequest(bookingId: 1), equals(true));
  });



  
// notification test

test('saveNotification', () async {
  expect(await notificationApi.saveNotification(notification: testNotification), equals(true));
});

test('getNotificationByID', () async {
  expect(await notificationApi.getNotificationByID(notificationId: 1), equals(true));
});

test('getAllNotificationsByStudentId', () async {
  expect(await notificationApi.getAllNotificationsByStudentId(studentId: 1), equals(true));
});

test('deleteNotificationByID', () async {
  expect(await notificationApi.deleteNotificationByID(notificationId: 1), equals(true));
});

test('updateDormitory', () async {
  expect(await notificationApi.updateNotification(notification: testNotification), equals(true));
});

// rating test - (test edilmedi)

test('saveRating', () async {
  expect(await ratingApi.saveRating(rating: testRating), equals(true));
});

test('getRatingByID', () async {
  expect(await ratingApi.getRatingByID(ratingId: 1), equals(true));
});









}