import 'package:json_annotation/json_annotation.dart';

part 'rating.g.dart';

@JsonSerializable()
class Rating {
  @JsonKey(includeIfNull: false)
  final int? id;
  final int? dormitoryId;
  final int? userId;
  final int? ratingNo;
  DateTime? createdAt;
  DateTime? updatedAt;

  Rating({
    required this.id,
    required this.dormitoryId,
    required this.userId,
    required this.ratingNo,
    this.createdAt,
    this.updatedAt
  });

  factory Rating.fromJson(Map<String, dynamic> json) => _$RatingFromJson(json);

  Map<String, dynamic> toJson() => _$RatingToJson(this);

  @override
  String toString() {
    return 'Rating{id: $id, dormitoryID: $dormitoryId, userID: $userId, ratingNo: $ratingNo, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}
