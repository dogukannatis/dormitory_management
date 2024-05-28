
import 'package:dormitory_management/locator.dart';
import 'package:dormitory_management/models/comment.dart';
import 'package:dormitory_management/repository/repository.dart';
import 'package:dormitory_management/viewmodels/dorm_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/dormitory.dart';


final commentManagerProvider = StateNotifierProvider<CommentManager, List<Comment>>((ref){
  return CommentManager(ref);
});

class CommentManager extends StateNotifier<List<Comment>> {
  final Ref ref;

  CommentManager(this.ref) : super([]);

  final _repository = locator<Repository>();

  Future<void> saveComment({required Comment comment}) async {
    ref.read(dormManagerProvider.notifier).updateDormitoryComment(comment: comment);
    state = [...state, comment];
    await _repository.saveComment(comment: comment);
  }

  Future<void> deleteCommentByID({required int commentId}) async {
    state.removeWhere((comment) => comment.commentId == commentId);
    state = state;
    await _repository.deleteCommentByID(commentId: commentId);
  }

  Future<List<Comment>> getAllCommentByDormitoryId({required int dormitoryId}) async {
    return state = await _repository.getAllCommentByDormitoryId(dormitoryId: dormitoryId);
  }







}