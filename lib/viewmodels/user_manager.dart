
import 'package:dormitory_management/locator.dart';
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

  Future<void> updateStudent({required Student user}) async {
    await _repository.updateStudent(user: user);
  }

  void signOut(){
    state = null;
  }




}