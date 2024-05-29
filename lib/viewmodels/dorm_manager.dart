
import 'package:dormitory_management/locator.dart';
import 'package:dormitory_management/models/dormitory_details.dart';
import 'package:dormitory_management/models/rating.dart';
import 'package:dormitory_management/models/room.dart';
import 'package:dormitory_management/repository/repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/comment.dart';
import '../models/dormitory.dart';


final dormManagerProvider = StateNotifierProvider<DormManager, List<Dormitory>>((ref){
  return DormManager(ref);
});

class DormManager extends StateNotifier<List<Dormitory>> {
  final Ref ref;

  DormManager(this.ref) : super([]);

  final _repository = locator<Repository>();

  void updateDormitoryComment({required Comment comment}) async {
    for(Dormitory dormitory in state){
      if(dormitory.dormitoryId == comment.dormitoryId){
        for(Comment? dormComment in dormitory.comments!){
          if(dormComment!.commentId == comment.commentId){
            dormComment = comment;
          }
        }
      }
    }
    state = state;
  }

  Future<List<Dormitory>> getAllDormitories() async {
    state = await _repository.getAllDormitories();
    debugPrint("Dorm list: $state");
    return state;
  }

  Future<void> saveDormitory({required Dormitory dormitory}) async {
    state = [...state, dormitory];
    await _repository.saveDormitory(dormitory: dormitory);
  }

  Future<Dormitory?> getDormitoryByID({required int dormitoryId}) async {
    return await _repository.getDormitoryByID(dormitoryId: dormitoryId);
  }


  Future<void> deleteRating({required int ratingId}) async {
    await _repository.deleteRating(ratingId: ratingId);
  }

  Future<List<Rating>> getRatingByDormitoryId({required int dormitoryId}) async {
    return await _repository.getRatingByDormitoryId(dormitoryId: dormitoryId);
  }

  Future<void> saveRoom({required Room room}) async {
    for(Dormitory dorm in state){
      dorm.rooms = [...?dorm.rooms, room];
    }
    state = state;
    await _repository.saveRoom(room: room);
  }

  Future<void> updateRoom({required Room room}) async {
    for(Dormitory dorm in state){
      for(Room? dormRoom in dorm.rooms!){
        if(dormRoom!.dormitoryId == room.dormitoryId && dormRoom.roomId == room.roomId){
          dormRoom = room;
        }
      }
    }
    state = state;
    await _repository.updateRoom(room: room);
  }

  Future<void> deleteDormitoryByID({required int dormitoryId}) async {
    state.removeWhere((dorm) => dorm.dormitoryId == dormitoryId);
    state = state;
    await _repository.deleteDormitoryByID(dormitoryId: dormitoryId);
  }

  Future<List<Room>> getRoomByDormitoryId({required int dormitoryId}) async {
    return await _repository.getRoomByDormitoryId(dormitoryId: dormitoryId);
  }

  Future<void> updateDormitory({required Dormitory dormitory}) async {
    for(Dormitory dorm in state){
      if(dorm.dormitoryId == dormitory.dormitoryId){
        dorm = dormitory;
      }
    }
    await _repository.updateDormitory(dormitory: dormitory);
  }






}