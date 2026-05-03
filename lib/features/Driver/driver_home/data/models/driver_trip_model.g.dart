// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_trip_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DriverTripModel _$DriverTripModelFromJson(Map<String, dynamic> json) =>
    DriverTripModel(
      tripId: json['tripId'] as String,
      routeFrom: json['routeFrom'] as String,
      routeTo: json['routeTo'] as String,
      startedAt: DateTime.parse(json['startedAt'] as String),
      distanceKm: (json['distanceKm'] as num).toDouble(),
      estimatedArrivalMinutes: (json['estimatedArrivalMinutes'] as num)
          .toDouble(),
      fromStationId: json['fromStationId'] as String,
      toStationId: json['toStationId'] as String,
    );

Map<String, dynamic> _$DriverTripModelToJson(DriverTripModel instance) =>
    <String, dynamic>{
      'tripId': instance.tripId,
      'routeFrom': instance.routeFrom,
      'routeTo': instance.routeTo,
      'startedAt': instance.startedAt.toIso8601String(),
      'distanceKm': instance.distanceKm,
      'estimatedArrivalMinutes': instance.estimatedArrivalMinutes,
      'fromStationId': instance.fromStationId,
      'toStationId': instance.toStationId,
    };
