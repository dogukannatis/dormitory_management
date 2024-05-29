import 'package:dormitory_management/models/dormitory.dart';
import 'package:dormitory_management/models/room.dart';
import 'package:dormitory_management/models/users/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'booking.g.dart';

@JsonSerializable()
class Booking {
  @JsonKey(includeIfNull: false)
  final int? bookingId;
  final int? userId;
  final int? dormitoryId;
  final int? roomId;
  final String? status;
  final String? paymentStatus;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? inMin;
  final DateTime? inMax;
  final DateTime? outMin;
  final DateTime? outMax;
  Dormitory? dormitory;
  Room? room;
  User? user;

  Booking({
    required this.bookingId,
    required this.userId,
    required this.dormitoryId,
    required this.roomId,
    this.status,
    this.paymentStatus,
    this.createdAt,
    this.updatedAt,
    this.inMin,
    this.inMax,
    this.outMin,
    this.outMax,
  });


  factory Booking.fromJson(Map<String, dynamic> json) => _$BookingFromJson(json);

  Map<String, dynamic> toJson() => _$BookingToJson(this);

  
}
