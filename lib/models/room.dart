import 'package:json_annotation/json_annotation.dart';

part 'room.g.dart';

@JsonSerializable()
class Room {
  @JsonKey(includeIfNull: false)
  final int? roomId;
  final int? dormitoryId;
  String? roomType;
  int? price;
  DateTime? createdAt;
  DateTime? updatedAt;

  Room({
    required this.roomId,
    required this.dormitoryId,
    this.roomType,
    this.price,
    this.createdAt,
    this.updatedAt
  });

  factory Room.fromJson(Map<String, dynamic> json) => _$RoomFromJson(json);

  Map<String, dynamic> toJson() => _$RoomToJson(this);

}
