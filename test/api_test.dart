

import 'package:dormitory_management/models/users/admin.dart';
import 'package:dormitory_management/models/users/student.dart';
import 'package:dormitory_management/services/admin_api.dart';
import 'package:dormitory_management/services/student_api.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  final api = StudentApi();

  final adminApi = AdminApi();

  Student testUser = Student(
      userId: 7,
      name: "asf",
      surName: "cukk",
      email: "test@mgmt.com",
      phoneNo: "01020304056",
      dob: DateTime.now(),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      studentNumber: "1900",
      address: "kıbrıs",
      password: "123",
      department: "it",
      gender: "erkek",
      profileUrl: "null",
      isEmailVerified: false,
      emergencyContactNo: "123"
    );

    Admin testAdmin = Admin(
      userId: null,
      name: "Test User zort",
      surName: "cukk",
      email: "test@mgmt.com",
      phoneNo: "01020304056",
      dob: DateTime.now(),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      address: "kıbrıs",
      password: "123", 
      profileUrl: "null",

  
    );


  test('Student Save', () async {
    expect(await api.saveStudent(user: testUser), equals("99"));
  });


  test('Get Student By ID', () async {
    expect(await api.getStudentByID(id: 3), equals("99"));
  });



  test('Get all students', () async {
    expect(await api.getAllStudents(), equals("99"));
  });

  test('Update student', () async {
    expect(await api.updateStudent(user: testUser), equals("99"));
  });

  test('get user by name', () async {
    expect(await api.getStudentByName(name: "dodo"), equals("99"));
  });


  test('viewStudentProfileInfo', () async {
    expect(await api.viewStudentProfileInfo(id: 7), equals("99"));
  });

  test('getNotificationByStudentId', () async {
    expect(await api.getNotificationByStudentId(id: 7), equals("99"));
  });


// admin test


  test('getAllAdmins', () async {
    expect(await adminApi.getAllAdmins(), equals([]));
  });

  
  test('saveAdmin', () async {
    expect(await adminApi.saveAdmin(user: testAdmin), equals(true));
  });

  test('getAdminByID', () async {
    expect(await adminApi.getAdminByID(id: 1), equals(true));
  });


}