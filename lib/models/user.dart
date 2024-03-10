
abstract class User {
  final String id;
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
    this.address
  });

  Map<String, dynamic> toMap() {
    return {
      "id"        : id,
      "email"     : email,
      "name"      : name,
      "surname"  : surname,
      "profileURL": profileURL,
      "phoneNumber": phoneNumber,
      "isEmailVerified": isEmailVerified,
      "address": address,
      "birthday" : birthday,
      "createdAt" : createdAt,
      "updatedAt" : updatedAt,
    };
  }

  User.fromMap(Map<String, dynamic> map):  // : this anlamında
        id = map["id"],
        email = map["email"],
        name = map["name"],
        surname = map["surname"],
        profileURL = map["profileURL"],
        phoneNumber = map["phoneNumber"],
        isEmailVerified = map["isEmailVerified"],
        address = map["address"],
        birthday = map["birthday"].toDate(),
        createdAt = map["createdAt"].toDate(),
        updatedAt = map["updatedAt"].toDate();

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
    required String id,
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
    };
  }

  Student.fromMap(Map<String, dynamic> map) : super.fromMap(map) {
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

class Admin extends User {

  String? studentNumber;
  String? department;
  String? gender;
  String? contactNumber;

  Admin({
    required String id,
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
    required String id,
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
    this.dormitoryID
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
