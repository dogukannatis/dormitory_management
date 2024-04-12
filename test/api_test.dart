

import 'package:dormitory_management/models/users/student.dart';
import 'package:dormitory_management/services/api.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  final api = Api();

  Student testUser = Student(
      userId: 2,
      name: "Test User",
      surName: "dodo",
      email: "test@mgmt.com",
      phoneNumber: "01020304056",
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


  test('Student Save', () async {
    expect(await api.saveStudent(user: testUser), equals("99"));
  });


  test('Get Student By ID', () async {
    expect(await api.getStudentByID(id: 3), equals("99"));
  });



  test('Get all students', () async {
    expect(await api.getAllStudents(), equals("99"));
  });

  test('Update students', () async {
    expect(await api.updateStudent(user: testUser), equals("99"));
  });




}