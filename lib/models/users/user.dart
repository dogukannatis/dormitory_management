import 'package:image_picker/image_picker.dart';
import 'package:json_annotation/json_annotation.dart';



abstract class User {
  final int? userId;
  final String? email;
  final String? name;
  final String? surName;
  final bool? isEmailVerified;
  final DateTime? dob;
  String? profileUrl;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? address;
  final String? phoneNo;
  final String? password;
  final String? userType;
  XFile? profilePhotoFile;

  User({
    required this.userId,
    this.email,
    this.name,
    this.surName,
    this.isEmailVerified,
    this.dob,
    this.profileUrl,
    this.createdAt,
    this.updatedAt,
    this.address,
    this.phoneNo,
    this.password,
    this.userType,
    this.profilePhotoFile
  });


  @override
  String toString() {
    return 'User{userId: $userId, email: $email, name: $name, surName: $surName, isEmailVerified: $isEmailVerified, dob: $dob, profileUrl: $profileUrl, createdAt: $createdAt, updatedAt: $updatedAt, address: $address}';
  }
}



/*


abstract class User {
  final int id;
  String? email;
  String? name;
  String? surname;
  String? phoneNumber;
  bool? isEmailVerified;
  DateTime? birthday;
  String? profileURL;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? address;
  String? phoneNo;
  String? password;

  User({
    required this.id,
    this.email,
    this.name,
    this.surname,
    this.phoneNumber,
    this.isEmailVerified,
    this.birthday,
    this.profileURL,
    this.createdAt,
    this.updatedAt,
    this.address,
    this.phoneNo,
    this.password
  });

  Map<String, dynamic> toMap() {
    return {
      "userId"        : id,
      "email"     : email,
      "name"      : name,
      "surName"  : surname,
      "profileUrl": profileURL,
      "phoneNumber": phoneNumber,
      "isEmailVerified": isEmailVerified,
      "address": address,
      "phoneNo" : phoneNo,
      "password" : password,
      "birthday" : birthday?.toIso8601String(),
      "createdAt" : createdAt?.toIso8601String(),
      "updatedAt" : updatedAt?.toIso8601String(),
    };
  }

  User.fromMap(Map<String, dynamic> map):  // : this anlamında
        id = map["userId"],
        email = map["email"],
        name = map["name"],
        surname = map["surName"],
        profileURL = map["profileUrl"],
        phoneNumber = map["phoneNumber"],
        isEmailVerified = map["isEmailVerified"],
        address = map["address"],
        phoneNo = map["phoneNo"],
        password = map["password"],
        birthday = DateTime.tryParse(map["dob"]),
        createdAt = DateTime.tryParse(map["createdAt"]),
        updatedAt = DateTime.tryParse(map["updatedAt"]);

  @override
  String toString() {
    return 'User{id: $id, email: $email, name: $name, surname: $surname, phoneNumber: $phoneNumber, isEmailVerified: $isEmailVerified, birthday: $birthday, profileURL: $profileURL, createdAt: $createdAt, updatedAt: $updatedAt, address: $address}';
  }
}

class Student extends User {

  String? studentNumber;
  String? department;
  String? gender;
  String? contactNumber;

  Student({
    required int id,
    String? email,
    String? name,
    String? surname,
    String? phoneNumber,
    bool? isEmailVerified,
    DateTime? birthday,
    String? profileURL,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? address,
    String? password,
    this.studentNumber,
    this.department,
    this.gender,
    this.contactNumber,
  }) : super(
    id: id,
    name: name,
    surname: surname,
    email: email,
    profileURL: profileURL,
    createdAt: createdAt,
    updatedAt: updatedAt,
    phoneNumber: phoneNumber,
    birthday: birthday,
    address: address,
    isEmailVerified: isEmailVerified,
    password: password
  );

  @override
  Map<String, dynamic> toMap() {
    return { 
      "userId"        : id, 
      "email"     : email,
      "studentNumber" : studentNumber, 
      "department" : department,
      "name"      : name, 
      "surName"   : surname, 
      "isEmailVerified"  : isEmailVerified, 
      "address"  : address, 
      "profileURL": profileURL,
     /*  "createdAt" : createdAt?.toString(), 
      "dob" : birthday?.toIso8601String(), 
      "updatedAt" : updatedAt?.toIso8601String(), */
      "emergencyContactNo" : contactNumber, 
      "phoneNo" : phoneNumber,
      "gender" : gender, 
      "password" : password 
    };
  }



  Student.fromMap(Map<String, dynamic> map) : super.fromMap(map) {
    studentNumber = map["studentNumber"];
    department = map["department"];
    gender = map["gender"];
    contactNumber = map["emergencyContactNo"];
  }

  @override
  String toString() {
    return 'Student{studentNumber: $studentNumber, department: $department, gender: $gender, contactNumber: $contactNumber}';
  }
}

class Admin extends User {

  String? studentNumber;
  String? department;
  String? gender;
  String? contactNumber;

  Admin({
    required int id,
    String? email,
    String? name,
    String? surname,
    String? phoneNumber,
    bool? isEmailVerified,
    DateTime? birthday,
    String? profileURL,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? address,
    String? password,
    this.studentNumber,
    this.department,
    this.gender,
    this.contactNumber,
  }) : super(
    id: id,
    password: password,
    name: name,
    surname: surname,
    email: email,
    profileURL: profileURL,
    createdAt: createdAt,
    updatedAt: updatedAt,
    phoneNumber: phoneNumber,
    birthday: birthday,
    address: address,
    isEmailVerified: isEmailVerified,
  );

  @override
  Map<String, dynamic> toMap() {
    return {
      "id"        : id,
      "email"     : email,
      "name"      : name,
      "surname"   : surname,
      "birthday"  : birthday,
      "phoneNumber"  : phoneNumber,
      "isEmailVerified"  : isEmailVerified,
      "address"  : address,
      "profileURL": profileURL,
      "createdAt" : createdAt,
      "updatedAt" : updatedAt,
      "password" : password
    };
  }

  Admin.fromMap(Map<String, dynamic> map) : super.fromMap(map) {
    studentNumber = map["studentNumber"];
    department = map["department"];
    gender = map["gender"];
    contactNumber = map["contactNumber"];
  }

  @override
  String toString() {
    return 'Student{studentNumber: $studentNumber, department: $department, gender: $gender, contactNumber: $contactNumber}';
  }
}

class DormitoryOwner extends User {

  String? dormitoryID;

  DormitoryOwner({
    required int id,
    String? email,
    String? name,
    String? surname,
    String? phoneNumber,
    bool? isEmailVerified,
    DateTime? birthday,
    String? profileURL,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? address,
    String? password,
    this.dormitoryID
  }) : super(
    id: id,
    name: name,
    surname: surname,
    email: email,
    password: password,
    profileURL: profileURL,
    createdAt: createdAt,
    updatedAt: updatedAt,
    phoneNumber: phoneNumber,
    birthday: birthday,
    address: address,
    isEmailVerified: isEmailVerified,
  );

  @override
  Map<String, dynamic> toMap() {
    return {
      "id"        : id,
      "email"     : email,
      "name"      : name,
      "surname"   : surname,
      "birthday"  : birthday,
      "phoneNumber"  : phoneNumber,
      "isEmailVerified"  : isEmailVerified,
      "address"  : address,
      "profileURL": profileURL,
      "createdAt" : createdAt,
      "updatedAt" : updatedAt,
      "password" : password
    };
  }

  DormitoryOwner.fromMap(Map<String, dynamic> map) : super.fromMap(map) {
    dormitoryID = map["dormitoryID"];
  }

  @override
  String toString() {
    return 'DormitoryOwner{dormitoryID: $dormitoryID}';
  }
}


*/