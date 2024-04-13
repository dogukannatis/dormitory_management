
import 'package:dormitory_management/repository/user_repository.dart';
import 'package:dormitory_management/services/student_api.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupLocator(){
  locator.registerLazySingleton(()=>UserRepository());
  locator.registerLazySingleton(()=>StudentApi());
}