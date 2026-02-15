// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TripModel _$TripModelFromJson(Map<String, dynamic> json) => TripModel(
  id: json['id'] as String,
  driverId: json['driverId'] as String,
  routeId: json['routeId'] as String,
  startedAt: DateTime.parse(json['startedAt'] as String),
  status: json['status'] as String,
);

Map<String, dynamic> _$TripModelToJson(TripModel instance) => <String, dynamic>{
  'id': instance.id,
  'driverId': instance.driverId,
  'routeId': instance.routeId,
  'startedAt': instance.startedAt.toIso8601String(),
  'status': instance.status,
};
