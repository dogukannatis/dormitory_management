
import 'package:dio/dio.dart';
import 'package:dormitory_management/locator.dart';
import 'package:dormitory_management/models/users/admin.dart';
import 'package:dormitory_management/models/users/dormitory_owner.dart';
import 'package:dormitory_management/models/users/student.dart';
import 'package:dormitory_management/models/users/user.dart';
import 'package:dormitory_management/repository/repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';


final userManagerProvider = StateNotifierProvider<UserManager, User?>((ref){
  return UserManager(ref);
});

class UserManager extends StateNotifier<User?> {
  final Ref ref;

  UserManager(this.ref) : super(null);

  final _repository = locator<Repository>();

  Future<List<User>> getAllUsers() async {
    return await _repository.getAllUsers();
  }

  Future<User?> login({required String email, required String password}) async {


    User? user = await _repository.login(email: email, password: password);
    state = user;
    return state;
    /*
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? _email = prefs.getString('email');
    String? _password = prefs.getString('password');

    if(_email != null && _password != null && (_email == email && _password == password)) {
      return state = await _repository.login(email: email, password: password);
    }else{
      return state = await _repository.login(email: email, password: password);
    }
     */

    
    
  }

  Future<void> saveStudent({required Student user}) async {
    await _repository.saveStudent(user: user);
  }

  Future<void> updateStudent({required Student user, bool? disableState = false}) async {
    if(disableState != true){
      state = user;
    }
    await _repository.updateStudent(user: user);
  }

  Future<void> updateDormitoryOwner({required DormitoryOwner user, bool? disableState}) async {
    if(disableState != true){
      state = user;
    }
    await _repository.updateDormitoryOwner(user: user);
  }

  Future<void> updateAdmin({required Admin user, bool? disableState}) async {
    if(disableState != true){
      state = user;
    }
    await _repository.updateAdmin(user: user);
  }

  /*
  Future<void> uploadPhoto({required FormData formData, bool? disableState}) async {
    String? url = await _repository.uploadPhoto(formData: formData);
    if(disableState != true){
      state!.profileUrl = url;
      state = state;
    }
  }
   */

  void signOut(){
    state = null;
  }




}