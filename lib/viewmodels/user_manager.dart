
import 'package:dormitory_management/locator.dart';
import 'package:dormitory_management/models/users/student.dart';
import 'package:dormitory_management/models/users/user.dart';
import 'package:dormitory_management/repository/repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum UserManagerState {idle, busy}

final userManagerProvider = StateNotifierProvider<UserManager, UserManagerState>((ref){
  return UserManager(ref);
});

class UserManager extends StateNotifier<UserManagerState> {
  final Ref ref;

  UserManager(this.ref) : super(UserManagerState.idle);

  final _userRepository = locator<Repository>();

  Future<User?> login({required String email, required String password}) async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? _email = prefs.getString('email');
    String? _password = prefs.getString('password');

    if(_email != null && _password != null && (_email == email && _password == password)) {

    }else{
      return null;
    }
    
    
  }

  Future<void> saveStudent({required Student user}) async {

    await _userRepository.saveStudent(user: user);

  }




}