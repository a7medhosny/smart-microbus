// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'station_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StationModel _$StationModelFromJson(Map<String, dynamic> json) => StationModel(
  id: json['id'] as String,
  name: json['name'] as String,
  city: json['city'] as String,
  lat: (json['lat'] as num).toDouble(),
  lng: (json['lng'] as num).toDouble(),
);

Map<String, dynamic> _$StationModelToJson(StationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'city': instance.city,
      'lat': instance.lat,
      'lng': instance.lng,
    };
