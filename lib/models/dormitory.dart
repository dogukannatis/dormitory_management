import 'package:json_annotation/json_annotation.dart';

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

  Dormitory({
    required this.dormitoryId,
    required this.universityId,
    required this.name,
    required this.quota,
    this.createdAt,
    this.updatedAt
  });

  factory Dormitory.fromJson(Map<String, dynamic> json) => _$DormitoryFromJson(json);

  Map<String, dynamic> toJson() => _$DormitoryToJson(this);

}
