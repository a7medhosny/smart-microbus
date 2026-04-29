// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'destination_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DestinationModel _$DestinationModelFromJson(Map<String, dynamic> json) =>
    DestinationModel(
      routeId: json['routeId'] as String,
      to: json['to'] as String,
      stationId: json['stationId'] as String,
    );

Map<String, dynamic> _$DestinationModelToJson(DestinationModel instance) =>
    <String, dynamic>{
      'routeId': instance.routeId,
      'to': instance.to,
      'stationId': instance.stationId,
    };
