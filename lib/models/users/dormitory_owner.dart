
import 'package:dormitory_management/models/users/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'dormitory_owner.g.dart';

@JsonSerializable()
class DormitoryOwner extends User {

  final String? dormitoryID;

  DormitoryOwner({
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
    this.dormitoryID
  }) : super(
    userId: userId,
    name: name,
    surName: surName,
    email: email,
    password: password,
    profileUrl: profileUrl,
    createdAt: createdAt,
    updatedAt: updatedAt,
    phoneNumber: phoneNumber,
    dob: dob,
    address: address,
    isEmailVerified: isEmailVerified,
  );

  factory DormitoryOwner.fromJson(Map<String, dynamic> json) => _$DormitoryOwnerFromJson(json);

  Map<String, dynamic> toJson() => _$DormitoryOwnerToJson(this);

  @override
  String toString() {
    return 'DormitoryOwner{dormitoryID: $dormitoryID}';
  }
}