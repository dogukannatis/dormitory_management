// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppNotification _$AppNotificationFromJson(Map<String, dynamic> json) =>
    AppNotification(
      id: json['id'] as int?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      senderId: json['senderId'] as int?,
      receiverId: json['receiverId'] as int?,
      imageUrl: json['imageUrl'] as String?,
      seen: json['seen'] as bool?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$AppNotificationToJson(AppNotification instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  val['title'] = instance.title;
  val['description'] = instance.description;
  val['senderId'] = instance.senderId;
  val['receiverId'] = instance.receiverId;
  val['imageUrl'] = instance.imageUrl;
  val['seen'] = instance.seen;
  val['createdAt'] = instance.createdAt?.toIso8601String();
  val['updatedAt'] = instance.updatedAt?.toIso8601String();
  return val;
}
