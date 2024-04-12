
import 'package:dormitory_management/models/users/user.dart';
import 'package:json_annotation/json_annotation.dart';

 part 'student.g.dart';

@JsonSerializable()
class Student extends User {

  final String? studentNumber;
  final String? department;
  final String? gender;
  final String? emergencyContactNo;

  Student({
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
    this.emergencyContactNo,
  }) : super(
    userId: userId,
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
    password: password
  );

 factory Student.fromJson(Map<String, dynamic> json) => _$StudentFromJson(json);

  Map<String, dynamic> toJson() => _$StudentToJson(this);

  @override
  String toString() {
    return 'Student{studentNumber: $studentNumber, department: $department, gender: $gender, phoneNo: $phoneNo}';
  }
}



