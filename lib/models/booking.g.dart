// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Booking _$BookingFromJson(Map<String, dynamic> json) => Booking(
      bookingId: json['bookingId'] as int?,
      userId: json['userId'] as int?,
      dormitoryId: json['dormitoryId'] as int?,
      roomId: json['roomId'] as int?,
      status: json['status'] as String?,
      paymentStatus: json['paymentStatus'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      inMin: json['inMin'] == null
          ? null
          : DateTime.parse(json['inMin'] as String),
      inMax: json['inMax'] == null
          ? null
          : DateTime.parse(json['inMax'] as String),
      outMin: json['outMin'] == null
          ? null
          : DateTime.parse(json['outMin'] as String),
      outMax: json['outMax'] == null
          ? null
          : DateTime.parse(json['outMax'] as String),
    )..dormitory = json['dormitory'] == null
        ? null
        : Dormitory.fromJson(json['dormitory'] as Map<String, dynamic>);

Map<String, dynamic> _$BookingToJson(Booking instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('bookingId', instance.bookingId);
  val['userId'] = instance.userId;
  val['dormitoryId'] = instance.dormitoryId;
  val['roomId'] = instance.roomId;
  val['status'] = instance.status;
  val['paymentStatus'] = instance.paymentStatus;
  val['createdAt'] = instance.createdAt?.toIso8601String();
  val['updatedAt'] = instance.updatedAt?.toIso8601String();
  val['inMin'] = instance.inMin?.toIso8601String();
  val['inMax'] = instance.inMax?.toIso8601String();
  val['outMin'] = instance.outMin?.toIso8601String();
  val['outMax'] = instance.outMax?.toIso8601String();
  val['dormitory'] = instance.dormitory;
  return val;
}
