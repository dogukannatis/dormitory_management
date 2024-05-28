import 'package:dormitory_management/locator.dart';
import 'package:dormitory_management/models/app_notification.dart';
import 'package:dormitory_management/models/booking.dart';
import 'package:dormitory_management/models/comment.dart';
import 'package:dormitory_management/models/dormitory.dart';
import 'package:dormitory_management/models/dormitory_details.dart';
import 'package:dormitory_management/models/users/student.dart';
import 'package:dormitory_management/models/users/user.dart';
import 'package:dormitory_management/services/comment_api.dart';
import 'package:dormitory_management/services/dormitory_api.dart';
import 'package:dormitory_management/services/dormitory_details.dart';
import 'package:dormitory_management/services/login_api.dart';
import 'package:dormitory_management/services/notification_api.dart';
import 'package:dormitory_management/services/rating_api.dart';

import 'package:dormitory_management/services/student_api.dart';
import 'package:flutter/cupertino.dart';

import '../services/booking_api.dart';


class Repository {
  final _studentApi = locator<StudentApi>();
  final _dormitoryApi = locator<DormitoryApi>();
  final _dormitoryDetailsApi = locator<DormitoryDetailsApi>();
  final _ratingApi = locator<RatingApi>();
  final _bookingApi = locator<BookingApi>();
  final _commentApi = locator<CommentApi>();
  final _loginApi = locator<LoginApi>();
  final _notificationApi = locator<NotificationApi>();

  Future<void> saveStudent({required Student user}) async {
    await _studentApi.saveStudent(user: user);
  }

  Future<void> saveNotification({required AppNotification notification}) async {
    await _notificationApi.saveNotification(notification: notification);
  }

  Future<void> updateStudent({required Student user}) async {
    await _studentApi.updateStudent(user: user);
  }

  Future<List<Dormitory>> getAllDormitories() async {
    List<Dormitory> dorms = [];
    dorms = await _dormitoryApi.getAllDormitories();
    for(Dormitory dorm in dorms){
      dorm.dormitoryDetails = await _dormitoryDetailsApi.getDormitoryDetailsByDormitoryID(dormitoryId: dorm.dormitoryId!);
      dorm.comments = await getAllCommentByDormitoryId(dormitoryId: dorm.dormitoryId!);
      //dorm.ratings = await _ratingApi.getRatingByDormitoryId(dormitoryId: dorm.dormitoryId!);
      debugPrint("details ${dorm.dormitoryDetails}");
    }
    return dorms;
  }

  Future<void> saveDormitory({required Dormitory dormitory}) async {
    await _dormitoryApi.saveDormitory(dormitory: dormitory);
  }

  Future<void> updateDormitory({required Dormitory dormitory}) async {
    await _dormitoryApi.updateDormitory(dormitory: dormitory);
  }

  Future<void> deleteDormitoryByID({required int dormitoryId}) async {
    await _dormitoryApi.deleteDormitoryByID(dormitoryId: dormitoryId);
  }

  Future<Dormitory?> getDormitoryByID({required int dormitoryId}) async {
    Dormitory? dorm = await _dormitoryApi.getDormitoryByID(dormitoryId: dormitoryId);
    if(dorm != null){
      dorm.dormitoryDetails = await _dormitoryDetailsApi.getDormitoryDetailsByDormitoryID(dormitoryId: dorm.dormitoryId!);
      dorm.comments = await getAllCommentByDormitoryId(dormitoryId: dorm.dormitoryId!);
    }
    return dorm;
  }
  Future<void> deleteCommentByID({required int commentId}) async {
    await _commentApi.deleteCommentByID(commentId: commentId);
  }

  Future<void> getDormitoryDetailsByDormitoryID({required int dormitoryId}) async {
    await _dormitoryDetailsApi.getDormitoryDetailsByDormitoryID(dormitoryId: dormitoryId);
  }

  Future<User?> login({required String email, required String password}) async {
    return await _loginApi.login(email: email, password: password);
  }

  Future<void> saveBooking({required Booking booking}) async {
    await _bookingApi.saveBooking(booking: booking);
  }

  Future<void> updateBooking({required Booking booking}) async {
    await _bookingApi.updateBooking(booking: booking);
  }

  Future<List<Booking>> getAllBookings() async {
    return await _bookingApi.getAllBookings();
  }

  Future<Booking?> getBookingByID({required int bookingId}) async {
    return await _bookingApi.getBookingByID(id: bookingId);
  }

  Future<List<Booking>> getBookingHistoryByStudentId({required int userId}) async {
    List<Booking> list = await _bookingApi.getBookingHistoryByStudentId(userId: userId);
    for(Booking booking in list){
      booking.dormitory = await getDormitoryByID(dormitoryId: booking.dormitoryId!);
    }
    return list;
  }

  Future<List<Comment>> getAllCommentByDormitoryId({required int dormitoryId}) async {
    List<Comment> comments =  await _commentApi.getAllCommentByDormitoryId(dormitoryId: dormitoryId);
    for(Comment comment in comments){
      comment.user = await _studentApi.getStudentByID(id: comment.userId!);
    }
    return comments;
  }

  Future<void> saveComment({required Comment comment}) async {
    await _commentApi.saveComment(comment: comment);
  }

}