// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'queue_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QueueItemModel _$QueueItemModelFromJson(Map<String, dynamic> json) =>
    QueueItemModel(
      queueId: json['queueId'] as String?,
      driverId: json['driverId'] as String?,
      driverName: json['driverName'] as String?,
      position: (json['position'] as num?)?.toInt(),
      status: json['status'] as String?,
      driversBefore: (json['driversBefore'] as num?)?.toInt(),
      totalDrivers: (json['totalDrivers'] as num?)?.toInt(),
      routeFrom: json['routeFrom'] as String?,
      routeTo: json['routeTo'] as String?,
    );

Map<String, dynamic> _$QueueItemModelToJson(QueueItemModel instance) =>
    <String, dynamic>{
      'queueId': instance.queueId,
      'driverId': instance.driverId,
      'driverName': instance.driverName,
      'position': instance.position,
      'status': instance.status,
      'driversBefore': instance.driversBefore,
      'totalDrivers': instance.totalDrivers,
      'routeFrom': instance.routeFrom,
      'routeTo': instance.routeTo,
    };
