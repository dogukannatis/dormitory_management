

import 'package:json_annotation/json_annotation.dart';

part 'app_notification.g.dart';

@JsonSerializable()
class AppNotification {
  @JsonKey(includeIfNull: false)
  final int? id;
  final String? title;
  final String? description;
  final int? senderId;
  final int? receiverId;
  String? imageUrl;
  bool? seen;
  DateTime? createdAt;
  DateTime? updatedAt;

  AppNotification({
    required this.id,
    required this.title,
    required this.description,
    required this.senderId,
    required this.receiverId,
    this.imageUrl,
    this.seen,
    this.createdAt,
    this.updatedAt
  });

  factory AppNotification.fromJson(Map<String, dynamic> json) => _$AppNotificationFromJson(json);

  Map<String, dynamic> toJson() => _$AppNotificationToJson(this);

  @override
  String toString() {
    return 'AppNotification{id: $id, title: $title, description: $description, senderId: $senderId, receiverId: $receiverId, imageURL: $imageUrl, seen: $seen, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}
