// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_location_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DriverLocationModel _$DriverLocationModelFromJson(Map<String, dynamic> json) =>
    DriverLocationModel(
      driverId: json['driverId'] as String,
      lastUpdated: DateTime.parse(json['lastUpdated'] as String),
      distance: (json['distance'] as num).toDouble(),
      duration: (json['duration'] as num).toDouble(),
      coordinates: const LocationListConverter().fromJson(
        json['coordinates'] as List,
      ),
    );

Map<String, dynamic> _$DriverLocationModelToJson(
  DriverLocationModel instance,
) => <String, dynamic>{
  'driverId': instance.driverId,
  'lastUpdated': instance.lastUpdated.toIso8601String(),
  'distance': instance.distance,
  'duration': instance.duration,
  'coordinates': const LocationListConverter().toJson(instance.coordinates),
};
