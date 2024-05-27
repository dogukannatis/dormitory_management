
import 'package:dormitory_management/models/users/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'comment.g.dart';

@JsonSerializable()
class Comment {
   @JsonKey(includeIfNull: false)
  final int? commentId;
  final int? userId;
  final int? dormitoryId;
  String? commentContent;
  DateTime? createdAt;
  DateTime? updatedAt;
  User? user;

  Comment({
    required this.commentId,
    required this.userId,
    required this.dormitoryId,
    this.commentContent,
    this.createdAt,
    this.updatedAt
  });

   factory Comment.fromJson(Map<String, dynamic> json) => _$CommentFromJson(json);

   Map<String, dynamic> toJson() => _$CommentToJson(this);

}
