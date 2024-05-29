
import 'package:dormitory_management/models/users/user.dart';
import 'package:image_picker/image_picker.dart';
import 'package:json_annotation/json_annotation.dart';

  part 'admin.g.dart';

@JsonSerializable()
class Admin extends User {

  @JsonKey(includeIfNull: false)
  @override
  int? get userId => super.userId;

  Admin({
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
    XFile? profilePhotoFile
  }) : super(
    userId: userId,
    password: password,
    name: name,
    surName: surName,
    email: email,
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

   factory Admin.fromJson(Map<String, dynamic> json) => _$AdminFromJson(json);

  Map<String, dynamic> toJson() => _$AdminToJson(this);

}

