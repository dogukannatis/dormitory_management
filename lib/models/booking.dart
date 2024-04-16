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
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Booking({
    required this.bookingId,
    required this.userId,
    required this.dormitoryId,
    required this.roomId,
    this.status,
    this.createdAt,
    this.updatedAt
  });


  factory Booking.fromJson(Map<String, dynamic> json) => _$BookingFromJson(json);

  Map<String, dynamic> toJson() => _$BookingToJson(this);

  
}
