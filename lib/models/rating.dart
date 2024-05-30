import 'package:dormitory_management/models/users/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'rating.g.dart';

@JsonSerializable()
class Rating {
  @JsonKey(includeIfNull: false)
  final int? ratingId;
  final int? dormitoryId;
  final int? userId;
  final int? ratingNo;
  final String? review;
  DateTime? createdAt;
  DateTime? updatedAt;
  @JsonKey(includeFromJson: false, includeToJson: false)
  User? user;

  Rating({
    required this.ratingId,
    required this.dormitoryId,
    required this.userId,
    required this.ratingNo,
    required this.review,
    this.createdAt,
    this.updatedAt
  });

  factory Rating.fromJson(Map<String, dynamic> json) => _$RatingFromJson(json);

  Map<String, dynamic> toJson() => _$RatingToJson(this);

  @override
  String toString() {
    return 'Rating{ratingId: $ratingId, dormitoryID: $dormitoryId, userID: $userId, ratingNo: $ratingNo, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}
