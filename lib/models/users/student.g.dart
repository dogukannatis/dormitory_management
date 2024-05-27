// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Student _$StudentFromJson(Map<String, dynamic> json) => Student(
      userId: json['userId'] as int?,
      email: json['email'] as String?,
      name: json['name'] as String?,
      surName: json['surName'] as String?,
      phoneNo: json['phoneNo'] as String?,
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
      userType: json['userType'] as String?,
      studentNumber: json['studentNumber'] as String?,
      department: json['department'] as String?,
      gender: json['gender'] as String?,
      emergencyContactNo: json['emergencyContactNo'] as String?,
    );

Map<String, dynamic> _$StudentToJson(Student instance) {
  final val = <String, dynamic>{
    'email': instance.email,
    'name': instance.name,
    'surName': instance.surName,
    'isEmailVerified': instance.isEmailVerified,
    'dob': instance.dob?.toIso8601String(),
    'profileUrl': instance.profileUrl,
    'createdAt': instance.createdAt?.toIso8601String(),
    'updatedAt': instance.updatedAt?.toIso8601String(),
    'address': instance.address,
    'phoneNo': instance.phoneNo,
    'password': instance.password,
    'userType': instance.userType,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('userId', instance.userId);
  val['studentNumber'] = instance.studentNumber;
  val['department'] = instance.department;
  val['gender'] = instance.gender;
  val['emergencyContactNo'] = instance.emergencyContactNo;
  return val;
}
