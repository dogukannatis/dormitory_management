import 'package:dormitory_management/models/rating.dart';
import 'package:dormitory_management/models/room.dart';
import 'package:dormitory_management/models/users/dormitory_owner.dart';
import 'package:json_annotation/json_annotation.dart';

import 'comment.dart';
import 'dormitory_details.dart';

part 'dormitory.g.dart';

@JsonSerializable()
class Dormitory {
  @JsonKey(includeIfNull: false)
  final int? dormitoryId;
  final int? universityId;
  String? name;
  int? quota;
  DateTime? createdAt;
  DateTime? updatedAt;
  DormitoryDetails? dormitoryDetails;
  @JsonKey(includeFromJson: false, includeToJson: false)
  List<Rating>? ratings;
  @JsonKey(includeFromJson: false, includeToJson: false)
  List<Comment?>? comments;
  @JsonKey(includeFromJson: false, includeToJson: false)
  List<Room?>? rooms;
  @JsonKey(includeFromJson: false, includeToJson: false)
  DormitoryOwner? user;

  Dormitory({
    required this.dormitoryId,
    required this.universityId,
    required this.name,
    required this.quota,
    this.createdAt,
    this.updatedAt,
    this.user
  });

  factory Dormitory.fromJson(Map<String, dynamic> json) => _$DormitoryFromJson(json);

  Map<String, dynamic> toJson() => _$DormitoryToJson(this);

}
