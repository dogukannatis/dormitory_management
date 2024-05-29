import 'package:dio/dio.dart';
import 'package:dormitory_management/locator.dart';
import 'package:dormitory_management/models/app_notification.dart';
import 'package:dormitory_management/models/booking.dart';
import 'package:dormitory_management/models/comment.dart';
import 'package:dormitory_management/models/dormitory.dart';
import 'package:dormitory_management/models/dormitory_details.dart';
import 'package:dormitory_management/models/room.dart';
import 'package:dormitory_management/models/users/admin.dart';
import 'package:dormitory_management/models/users/dormitory_owner.dart';
import 'package:dormitory_management/models/users/student.dart';
import 'package:dormitory_management/models/users/user.dart';
import 'package:dormitory_management/services/admin_api.dart';
import 'package:dormitory_management/services/comment_api.dart';
import 'package:dormitory_management/services/dormitory_api.dart';
import 'package:dormitory_management/services/dormitory_details.dart';
import 'package:dormitory_management/services/dormitory_owner_api.dart';
import 'package:dormitory_management/services/login_api.dart';
import 'package:dormitory_management/services/notification_api.dart';
import 'package:dormitory_management/services/rating_api.dart';

import 'package:dormitory_management/services/student_api.dart';
import 'package:flutter/cupertino.dart';

import '../models/rating.dart';
import '../services/booking_api.dart';
import '../services/room_api.dart';


class Repository {
  final _studentApi = locator<StudentApi>();
  final _dormitoryApi = locator<DormitoryApi>();
  final _dormitoryDetailsApi = locator<DormitoryDetailsApi>();
  final _ratingApi = locator<RatingApi>();
  final _bookingApi = locator<BookingApi>();
  final _commentApi = locator<CommentApi>();
  final _loginApi = locator<LoginApi>();
  final _notificationApi = locator<NotificationApi>();
  final _dormitoryOwnerApi = locator<DormitoryOwnerApi>();
  final _adminApi = locator<AdminApi>();
  final _roomApi = locator<RoomApi>();

  Future<List<User>> getAllUsers() async {
    List<User> students = await _studentApi.getAllStudents();
    List<User> admins = await _adminApi.getAllAdmins();
    List<User> dormOwners = await _dormitoryOwnerApi.getAllDormitoryOwners();
    return [...admins, ...dormOwners, ...students];
  }

  Future<void> saveStudent({required Student user}) async {
    await _studentApi.saveStudent(user: user);
  }

  Future<void> saveNotification({required AppNotification notification}) async {
    await _notificationApi.saveNotification(notification: notification);
  }

  Future<List<AppNotification>> getAllNotificationsByStudentId({required int studentId}) async {
    return await _notificationApi.getAllNotificationsByStudentId(studentId: studentId);
  }

  Future<void> updateStudent({required Student user}) async {
    await _studentApi.updateStudent(user: user);
  }

  Future<void> updateDormitoryOwner({required DormitoryOwner user}) async {
    await _dormitoryOwnerApi.updateDormitoryOwner(user: user);
  }

  Future<void> updateAdmin({required Admin user}) async {
    await _adminApi.updateAdmin(user: user);
  }

  Future<List<String>> uploadPhoto({required FormData formData, required int detailId}) async {
    await _dormitoryDetailsApi.uploadPhoto(formData: formData);
    return await _dormitoryDetailsApi.getPhoto(detailId: detailId);
  }

  Future<List<Dormitory>> getAllDormitories() async {
    List<Dormitory> dorms = [];
    dorms = await _dormitoryApi.getAllDormitories();
    for(Dormitory dorm in dorms){
      dorm.dormitoryDetails = await _dormitoryDetailsApi.getDormitoryDetailsByDormitoryID(dormitoryId: dorm.dormitoryId!);
      dorm.comments = await getAllCommentByDormitoryId(dormitoryId: dorm.dormitoryId!);
      dorm.rooms = await _roomApi.getRoomByDormitoryId(dormitoryId: dorm.dormitoryId!);
      dorm.ratings = await _ratingApi.getRatingByDormitoryId(dormitoryId: dorm.dormitoryId!);
      debugPrint("details ${dorm.dormitoryDetails}");
    }
    return dorms;
  }

  Future<List<Rating>> getRatingByDormitoryId({required int dormitoryId}) async {
    List<Rating> ratings = await _ratingApi.getRatingByDormitoryId(dormitoryId: dormitoryId);
    for(Rating rating in ratings){
      rating.user = await _studentApi.getStudentByID(id: rating.userId!);
    }
    return ratings;
  }

  Future<void> deleteRating({required int ratingId}) async {
    await _ratingApi.deleteRatingByID(ratingId: ratingId);
  }

  Future<void> saveDormitory({required Dormitory dormitory}) async {
    Dormitory? dorm = await _dormitoryApi.saveDormitory(dormitory: dormitory);
    if(dorm != null){
      dormitory.dormitoryDetails!.dormitoryId = dorm.dormitoryId;
      await _dormitoryDetailsApi.saveDormitoryDetails(dormitoryDetails: dormitory.dormitoryDetails!);
    }
  }


  Future<void> updateDormitory({required Dormitory dormitory}) async {
    await _dormitoryApi.updateDormitory(dormitory: dormitory);
    await _dormitoryDetailsApi.updateDormitoryDetails(dormitoryDetails: dormitory.dormitoryDetails!);
  }

  Future<void> deleteDormitoryByID({required int dormitoryId}) async {
    await _dormitoryApi.deleteDormitoryByID(dormitoryId: dormitoryId);
  }

  Future<void> sendNotificationToAllDormStudents({required AppNotification appNotification}) async {
    await _notificationApi.sendNotificationToAllDormStudents(appNotification: appNotification);
  }

  Future<void> saveRate({required Rating rating}) async {
    await _ratingApi.saveRating(rating: rating);
  }

  Future<List<Room>> getRoomByDormitoryId({required int dormitoryId}) async {
    return await _roomApi.getRoomByDormitoryId(dormitoryId: dormitoryId);
  }

  Future<void> saveRoom({required Room room}) async {
    await _roomApi.saveRoom(room: room);
  }

  Future<void> deleteRoom({required int roomId}) async {
    await _roomApi.deleteRoom(roomId: roomId);
  }

  Future<void> updateRoom({required Room room}) async {
    await _roomApi.updateRoom(room: room);
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

  Future<bool?> approveStudentsBookingRequest({required int bookingId,}) async {
    return await _dormitoryOwnerApi.approveStudentsBookingRequest(bookingId: bookingId);
  }

  Future<Booking?> getApprovedBookingByUserId({required int userId}) async {
    Booking? booking = await _dormitoryOwnerApi.getApprovedBookingByUserId(userId: userId);
    if(booking!.status != "Approved"){
      return null;
    }

    booking.user = await _studentApi.getStudentByID(id: booking.userId!);
    booking.dormitory = await _dormitoryApi.getDormitoryByID(dormitoryId: booking.dormitoryId!);
    if(booking.dormitory != null){
      booking.dormitory?.dormitoryDetails = await _dormitoryDetailsApi.getDormitoryDetailsByDormitoryID(dormitoryId: booking.dormitoryId!);
    }

    return booking;
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

  Future<List<Booking>> getBookingsByDormitoryId({required int dormitoryId}) async {
    List<Booking> bookings = await _bookingApi.getBookingsByDormitoryId(dormitoryId: dormitoryId);
    for(Booking booking in bookings){
      booking.user = await _studentApi.getStudentByID(id: booking.userId!);
      List<Room> rooms = await _roomApi.getRoomByDormitoryId(dormitoryId: booking.dormitoryId!);
      for(Room room in rooms){
        if(room.roomId == booking.roomId){
          booking.room = room;
        }
      }
    }
    return bookings;
  }

  Future<List<Booking>> getBookingHistoryByStudentId({required int userId}) async {
    List<Booking> list = await _bookingApi.getBookingHistoryByStudentId(userId: userId);
    for(Booking booking in list){
      booking.dormitory = await getDormitoryByID(dormitoryId: booking.dormitoryId!);
     // booking.room = await _roomApi.getRoomById(roomId: booking.roomId!);
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