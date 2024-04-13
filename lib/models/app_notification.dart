

import 'package:json_annotation/json_annotation.dart';

part 'app_notification.g.dart';

@JsonSerializable()
class AppNotification {
  @JsonKey(includeIfNull: false)
  final String? id;
  final String? title;
  final String? description;
  final String? senderID;
  final String? receiverID;
  String? imageURL;
  bool? seen;
  DateTime? createdAt;
  DateTime? updatedAt;

  AppNotification({
    required this.id,
    required this.title,
    required this.description,
    required this.senderID,
    required this.receiverID,
    this.imageURL,
    this.seen,
    this.createdAt,
    this.updatedAt
  });

  factory AppNotification.fromJson(Map<String, dynamic> json) => _$AppNotificationFromJson(json);

  Map<String, dynamic> toJson() => _$AppNotificationToJson(this);

  @override
  String toString() {
    return 'AppNotification{id: $id, title: $title, description: $description, senderID: $senderID, receiverID: $receiverID, imageURL: $imageURL, seen: $seen, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}
