import 'package:dormitory_management/models/dormitory.dart';
import 'package:dormitory_management/models/room.dart';
import 'package:dormitory_management/models/users/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'booking.g.dart';

@JsonSerializable()
class Booking {
  @JsonKey(includeIfNull: false)
  int? bookingId;
  int? userId;
  int? dormitoryId;
  int? roomId;
  String? status;
  String? paymentStatus;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? inMin;
  DateTime? inMax;
  DateTime? outMin;
  DateTime? outMax;
  @JsonKey(ignore: true)
  Dormitory? dormitory;
  @JsonKey(ignore: true)
  Room? room;
  @JsonKey(ignore: true)
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
