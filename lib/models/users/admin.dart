
import 'package:dormitory_management/models/users/user.dart';
import 'package:json_annotation/json_annotation.dart';

  part 'admin.g.dart';

@JsonSerializable()
class Admin extends User {

  final String? studentNumber;
  final String? department;
  final String? gender;
  final String? contactNumber;

  Admin({
    required int userId,
    String? email,
    String? name,
    String? surName,
    String? phoneNumber,
    bool? isEmailVerified,
    DateTime? dob,
    String? profileUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? address,
    String? password,
    this.studentNumber,
    this.department,
    this.gender,
    this.contactNumber,
  }) : super(
    userId: userId,
    password: password,
    name: name,
    surName: surName,
    email: email,
    profileUrl: profileUrl,
    createdAt: createdAt,
    updatedAt: updatedAt,
    phoneNumber: phoneNumber,
    dob: dob,
    address: address,
    isEmailVerified: isEmailVerified,
  );

   factory Admin.fromJson(Map<String, dynamic> json) => _$AdminFromJson(json);

  Map<String, dynamic> toJson() => _$AdminToJson(this);

  @override
  String toString() {
    return 'Student{studentNumber: $studentNumber, department: $department, gender: $gender, contactNumber: $contactNumber}';
  }
}

