// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dormitory.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Dormitory _$DormitoryFromJson(Map<String, dynamic> json) => Dormitory(
      dormitoryId: json['dormitoryId'] as int?,
      universityId: json['universityId'] as int?,
      name: json['name'] as String?,
      quota: json['quota'] as int?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    )
      ..dormitoryDetails = json['dormitoryDetails'] == null
          ? null
          : DormitoryDetails.fromJson(
              json['dormitoryDetails'] as Map<String, dynamic>)
      ..rating = json['rating'] == null
          ? null
          : Rating.fromJson(json['rating'] as Map<String, dynamic>);

Map<String, dynamic> _$DormitoryToJson(Dormitory instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('dormitoryId', instance.dormitoryId);
  val['universityId'] = instance.universityId;
  val['name'] = instance.name;
  val['quota'] = instance.quota;
  val['createdAt'] = instance.createdAt?.toIso8601String();
  val['updatedAt'] = instance.updatedAt?.toIso8601String();
  val['dormitoryDetails'] = instance.dormitoryDetails;
  val['rating'] = instance.rating;
  return val;
}
