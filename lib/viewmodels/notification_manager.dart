
import 'package:dormitory_management/locator.dart';
import 'package:dormitory_management/models/app_notification.dart';
import 'package:dormitory_management/models/comment.dart';
import 'package:dormitory_management/repository/repository.dart';
import 'package:dormitory_management/viewmodels/dorm_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/dormitory.dart';


final notificationManagerProvider = StateNotifierProvider<NotificationManager, List<AppNotification>>((ref){
  return NotificationManager(ref);
});

class NotificationManager extends StateNotifier<List<AppNotification>> {
  final Ref ref;

  NotificationManager(this.ref) : super([]);

  final _repository = locator<Repository>();

  Future<void> saveNotification({required AppNotification notification}) async {
    state = [...state, notification];
    await _repository.saveNotification(notification: notification);
  }

  Future<List<AppNotification>> getAllNotificationsByStudentId({required int studentId}) async {
    return state = await _repository.getAllNotificationsByStudentId(studentId: studentId);
  }








}