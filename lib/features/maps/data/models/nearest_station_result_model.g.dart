// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nearest_station_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NearestStationResultModel _$NearestStationResultModelFromJson(
  Map<String, dynamic> json,
) => NearestStationResultModel(
  stationId: json['stationId'] as String,
  stationName: json['stationName'] as String,
  stationCity: json['stationCity'] as String,
  stationLat: (json['stationLat'] as num).toDouble(),
  stationLng: (json['stationLng'] as num).toDouble(),
  distanceKm: (json['distanceKm'] as num).toDouble(),
  etaMinutes: (json['etaMinutes'] as num).toDouble(),
  points: (json['points'] as List<dynamic>)
      .map(
        (e) => (e as List<dynamic>).map((e) => (e as num).toDouble()).toList(),
      )
      .toList(),
);

Map<String, dynamic> _$NearestStationResultModelToJson(
  NearestStationResultModel instance,
) => <String, dynamic>{
  'stationId': instance.stationId,
  'stationName': instance.stationName,
  'stationCity': instance.stationCity,
  'stationLat': instance.stationLat,
  'stationLng': instance.stationLng,
  'distanceKm': instance.distanceKm,
  'etaMinutes': instance.etaMinutes,
  'points': instance.points,
};
