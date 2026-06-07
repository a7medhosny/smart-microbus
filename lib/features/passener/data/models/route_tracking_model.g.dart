// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route_tracking_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RouteTrackingModel _$RouteTrackingModelFromJson(Map<String, dynamic> json) =>
    RouteTrackingModel(
      numberOfMicrobusesInQueue: (json['numberOfMicrobusesInQueue'] as num)
          .toInt(),
      numberOfMicrobusesOnTheWay: (json['numberOfMicrobusesOnTheWay'] as num)
          .toInt(),
      nearestArrivalMinutes: (json['nearestArrivalMinutes'] as num?)?.toInt(),
    );

Map<String, dynamic> _$RouteTrackingModelToJson(RouteTrackingModel instance) =>
    <String, dynamic>{
      'numberOfMicrobusesInQueue': instance.numberOfMicrobusesInQueue,
      'numberOfMicrobusesOnTheWay': instance.numberOfMicrobusesOnTheWay,
      'nearestArrivalMinutes': instance.nearestArrivalMinutes,
    };
