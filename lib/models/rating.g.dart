// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rating.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Rating _$RatingFromJson(Map<String, dynamic> json) => Rating(
      ratingId: json['ratingId'] as int?,
      dormitoryId: json['dormitoryId'] as int?,
      userId: json['userId'] as int?,
      ratingNo: json['ratingNo'] as int?,
      review: json['review'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$RatingToJson(Rating instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('ratingId', instance.ratingId);
  val['dormitoryId'] = instance.dormitoryId;
  val['userId'] = instance.userId;
  val['ratingNo'] = instance.ratingNo;
  val['review'] = instance.review;
  val['createdAt'] = instance.createdAt?.toIso8601String();
  val['updatedAt'] = instance.updatedAt?.toIso8601String();
  return val;
}
