// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dormitory_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DormitoryDetails _$DormitoryDetailsFromJson(Map<String, dynamic> json) =>
    DormitoryDetails(
      detailId: json['detailId'] as int?,
      dormitoryId: json['dormitoryId'] as int?,
      contactNo: json['contactNo'] as String?,
      email: json['email'] as String?,
      faxNo: json['faxNo'] as String?,
      address: json['address'] as String?,
      capacity: json['capacity'] as int?,
      description: json['description'] as String?,
      internetSpeed: json['internetSpeed'] as String?,
      hasKitchen: json['hasKitchen'] as bool?,
      hasCleanService: json['hasCleanService'] as bool?,
      hasShowerAndToilet: json['hasShowerAndToilet'] as bool?,
      hasBalcony: json['hasBalcony'] as bool?,
      hasTV: json['hasTV'] as bool?,
      hasMicrowave: json['hasMicrowave'] as bool?,
      hasAirConditioning: json['hasAirConditioning'] as bool?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      photoUrls: json['photoUrls'] as List<dynamic>?,
      price: json['price'] as int?,
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$DormitoryDetailsToJson(DormitoryDetails instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('detailId', instance.detailId);
  val['dormitoryId'] = instance.dormitoryId;
  val['contactNo'] = instance.contactNo;
  val['email'] = instance.email;
  val['faxNo'] = instance.faxNo;
  val['address'] = instance.address;
  val['capacity'] = instance.capacity;
  val['description'] = instance.description;
  val['internetSpeed'] = instance.internetSpeed;
  val['hasKitchen'] = instance.hasKitchen;
  val['hasCleanService'] = instance.hasCleanService;
  val['hasShowerAndToilet'] = instance.hasShowerAndToilet;
  val['hasBalcony'] = instance.hasBalcony;
  val['hasTV'] = instance.hasTV;
  val['hasMicrowave'] = instance.hasMicrowave;
  val['hasAirConditioning'] = instance.hasAirConditioning;
  val['price'] = instance.price;
  writeNotNull('photoUrls', instance.photoUrls);
  val['createdAt'] = instance.createdAt?.toIso8601String();
  val['updatedAt'] = instance.updatedAt?.toIso8601String();
  return val;
}
