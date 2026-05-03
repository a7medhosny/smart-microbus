// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_current_status_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DriverCurrentStatusModel _$DriverCurrentStatusModelFromJson(
  Map<String, dynamic> json,
) => DriverCurrentStatusModel(
  driverId: json['driverId'] as String,
  status: json['status'] as String,
  queue: json['queue'] == null
      ? null
      : QueueItemModel.fromJson(json['queue'] as Map<String, dynamic>),
  trip: json['trip'] == null
      ? null
      : DriverTripModel.fromJson(json['trip'] as Map<String, dynamic>),
);

Map<String, dynamic> _$DriverCurrentStatusModelToJson(
  DriverCurrentStatusModel instance,
) => <String, dynamic>{
  'driverId': instance.driverId,
  'status': instance.status,
  'queue': instance.queue,
  'trip': instance.trip,
};
