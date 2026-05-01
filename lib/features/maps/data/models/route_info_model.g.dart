// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RouteInfoModel _$RouteInfoModelFromJson(Map<String, dynamic> json) =>
    RouteInfoModel(
      distanceKm: (json['distanceKm'] as num).toDouble(),
      etaMinutes: (json['etaMinutes'] as num).toDouble(),
      points: RouteInfoModel._pointsFromJson(json['points'] as List),
    );

Map<String, dynamic> _$RouteInfoModelToJson(RouteInfoModel instance) =>
    <String, dynamic>{
      'distanceKm': instance.distanceKm,
      'etaMinutes': instance.etaMinutes,
      'points': instance.points,
    };
