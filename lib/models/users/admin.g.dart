// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Admin _$AdminFromJson(Map<String, dynamic> json) => Admin(
      userId: json['userId'] as int,
      email: json['email'] as String?,
      name: json['name'] as String?,
      surName: json['surName'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      isEmailVerified: json['isEmailVerified'] as bool?,
      dob: json['dob'] == null ? null : DateTime.parse(json['dob'] as String),
      profileUrl: json['profileUrl'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      address: json['address'] as String?,
      password: json['password'] as String?,
      studentNumber: json['studentNumber'] as String?,
      department: json['department'] as String?,
      gender: json['gender'] as String?,
      contactNumber: json['contactNumber'] as String?,
    );

Map<String, dynamic> _$AdminToJson(Admin instance) => <String, dynamic>{
      'userId': instance.userId,
      'email': instance.email,
      'name': instance.name,
      'surName': instance.surName,
      'phoneNumber': instance.phoneNumber,
      'isEmailVerified': instance.isEmailVerified,
      'dob': instance.dob?.toIso8601String(),
      'profileUrl': instance.profileUrl,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'address': instance.address,
      'password': instance.password,
      'studentNumber': instance.studentNumber,
      'department': instance.department,
      'gender': instance.gender,
      'contactNumber': instance.contactNumber,
    };
