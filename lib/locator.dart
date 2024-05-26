
import 'package:dormitory_management/repository/repository.dart';
import 'package:dormitory_management/services/dormitory_api.dart';
import 'package:dormitory_management/services/dormitory_details.dart';
import 'package:dormitory_management/services/login_api.dart';
import 'package:dormitory_management/services/student_api.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupLocator(){
  locator.registerLazySingleton(()=>Repository());
  locator.registerLazySingleton(()=>StudentApi());
  locator.registerLazySingleton(()=>DormitoryDetailsApi());
  locator.registerLazySingleton(()=>DormitoryApi());
  locator.registerLazySingleton(()=>LoginApi());
}