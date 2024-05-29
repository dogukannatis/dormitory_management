
import 'package:dormitory_management/models/users/user.dart';
import 'package:image_picker/image_picker.dart';
import 'package:json_annotation/json_annotation.dart';

 part 'student.g.dart';

@JsonSerializable()
class Student extends User {

  @JsonKey(includeIfNull: false)
  @override
  int? get userId => super.userId;

  final String? studentNumber;
  final String? department;
  final String? gender;
  final String? emergencyContactNo;

  Student({
    required int? userId,
    String? email,
    String? name,
    String? surName,
    String? phoneNo,
    bool? isEmailVerified,
    DateTime? dob,
    String? profileUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? address,
    String? password,
    String? userType,
    this.studentNumber,
    this.department,
    this.gender,
    this.emergencyContactNo,
    XFile? profilePhotoFile
  }) : super(
    userId: userId,
    name: name,
    surName: surName,
    email: email,
    profileUrl: profileUrl,
    createdAt: createdAt,
    updatedAt: updatedAt,
    phoneNo: phoneNo,
    dob: dob,
    address: address,
    isEmailVerified: isEmailVerified,
      userType: userType,
    password: password,
      profilePhotoFile: profilePhotoFile
  );

 factory Student.fromJson(Map<String, dynamic> json) => _$StudentFromJson(json);

  Map<String, dynamic> toJson() => _$StudentToJson(this);

  @override
  String toString() {
    return 'Student{studentNumber: $studentNumber, department: $department, gender: $gender, phoneNo: $phoneNo}';
  }
}



