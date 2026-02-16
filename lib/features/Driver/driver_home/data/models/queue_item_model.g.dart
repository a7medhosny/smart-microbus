// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'queue_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QueueItemModel _$QueueItemModelFromJson(Map<String, dynamic> json) =>
    QueueItemModel(
      queueId: json['queueId'] as String,
      driverId: json['driverId'] as String,
      position: (json['position'] as num).toInt(),
      status: json['status'] as String,
      joinedAt: DateTime.parse(json['joinedAt'] as String),
    );

Map<String, dynamic> _$QueueItemModelToJson(QueueItemModel instance) =>
    <String, dynamic>{
      'queueId': instance.queueId,
      'driverId': instance.driverId,
      'position': instance.position,
      'status': instance.status,
      'joinedAt': instance.joinedAt.toIso8601String(),
    };
