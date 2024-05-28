
import 'package:dormitory_management/locator.dart';
import 'package:dormitory_management/models/booking.dart';
import 'package:dormitory_management/repository/repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/dormitory.dart';


final bookingManagerProvider = StateNotifierProvider<BookingManager, List<Booking>>((ref){
  return BookingManager(ref);
});

class BookingManager extends StateNotifier<List<Booking>> {
  final Ref ref;

  BookingManager(this.ref) : super([]);

  final _repository = locator<Repository>();


  Future<List<Booking>> getAllBookings() async {
    state = await _repository.getAllBookings();
    debugPrint("Dorm list: $state");
    return state;
  }

  Future<void> saveBooking({required Booking booking}) async {
    state = [...state, booking];

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String>? lastBookings = prefs.getStringList("bookings");
    await prefs.setStringList('bookings', [...?lastBookings, booking.bookingId.toString()]);


    await _repository.saveBooking(booking: booking);
  }


  Future<void> deleteBookingByID({required int bookingId}) async {
    state.removeWhere((booking) => booking.bookingId == bookingId);
    state = state;
    await _repository.deleteDormitoryByID(dormitoryId: bookingId);
  }

  Future<void> updateBooking({required Booking booking}) async {
    for(Booking bookingElement in state){
      if(bookingElement.dormitoryId == booking.dormitoryId){
        bookingElement = booking;
      }
    }
    await _repository.updateBooking(booking: booking);
  }

  Future<Booking?> getBookingByID({required int bookingId}) async {
    return await _repository.getBookingByID(bookingId: bookingId);
  }

  Future<List<Booking>> getBookingHistoryByStudentId({required int userId}) async {
    return await _repository.getBookingHistoryByStudentId(userId: userId);
  }






}