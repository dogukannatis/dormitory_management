
import 'package:dormitory_management/locator.dart';
import 'package:dormitory_management/repository/user_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum UserManagerState {idle, busy}

final userManagerProvider = StateNotifierProvider<UserManager, UserManagerState>((ref){
  return UserManager(ref);
});

class UserManager extends StateNotifier<UserManagerState> {
  final Ref ref;

  UserManager(this.ref) : super(UserManagerState.idle);

  final _userRepository = locator<UserRepository>();



}