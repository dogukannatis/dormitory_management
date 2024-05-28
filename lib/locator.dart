
import 'package:dormitory_management/repository/repository.dart';
import 'package:dormitory_management/services/admin_api.dart';
import 'package:dormitory_management/services/booking_api.dart';
import 'package:dormitory_management/services/comment_api.dart';
import 'package:dormitory_management/services/dormitory_api.dart';
import 'package:dormitory_management/services/dormitory_details.dart';
import 'package:dormitory_management/services/dormitory_owner_api.dart';
import 'package:dormitory_management/services/login_api.dart';
import 'package:dormitory_management/services/notification_api.dart';
import 'package:dormitory_management/services/rating_api.dart';
import 'package:dormitory_management/services/room_api.dart';
import 'package:dormitory_management/services/student_api.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupLocator(){
  locator.registerLazySingleton(()=>Repository());
  locator.registerLazySingleton(()=>StudentApi());
  locator.registerLazySingleton(()=>DormitoryDetailsApi());
  locator.registerLazySingleton(()=>RatingApi());
  locator.registerLazySingleton(()=>BookingApi());
  locator.registerLazySingleton(()=>DormitoryApi());
  locator.registerLazySingleton(()=>CommentApi());
  locator.registerLazySingleton(()=>LoginApi());
  locator.registerLazySingleton(()=>NotificationApi());
  locator.registerLazySingleton(()=>DormitoryOwnerApi());
  locator.registerLazySingleton(()=>AdminApi());
  locator.registerLazySingleton(()=>RoomApi());
}