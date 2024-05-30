
import 'package:dormitory_management/models/users/user.dart';
import 'package:image_picker/image_picker.dart';
import 'package:json_annotation/json_annotation.dart';

part 'dormitory_owner.g.dart';

@JsonSerializable()
class DormitoryOwner extends User {

  @JsonKey(includeIfNull: false)
  @override
  int? get userId => super.userId;
  
  int? dormitoryId;

  DormitoryOwner({
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
    this.dormitoryId,
    XFile? profilePhotoFile
  }) : super(
    userId: userId,
    name: name,
    surName: surName,
    email: email,
    password: password,
    profileUrl: profileUrl,
    createdAt: createdAt,
    updatedAt: updatedAt,
    phoneNo: phoneNo,
    dob: dob,
    address: address,
    userType: userType,
    isEmailVerified: isEmailVerified,
      profilePhotoFile: profilePhotoFile
  );

  factory DormitoryOwner.fromJson(Map<String, dynamic> json) => _$DormitoryOwnerFromJson(json);

  Map<String, dynamic> toJson() => _$DormitoryOwnerToJson(this);

  @override
  String toString() {
    return 'DormitoryOwner{dormitoryID: $dormitoryId}';
  }
}