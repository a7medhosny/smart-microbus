// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route_summary_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RouteSummaryModel _$RouteSummaryModelFromJson(Map<String, dynamic> json) =>
    RouteSummaryModel(
      price: (json['price'] as num).toDouble(),
      distanceKm: (json['distanceKm'] as num).toDouble(),
      numberOfMicrobusesInQueue: (json['numberOfMicrobusesInQueue'] as num)
          .toInt(),
      numberOfMicrobusesOnTheWay: (json['numberOfMicrobusesOnTheWay'] as num)
          .toInt(),
      nearestArrivalMinutes: (json['nearestArrivalMinutes'] as num).toInt(),
    );

Map<String, dynamic> _$RouteSummaryModelToJson(RouteSummaryModel instance) =>
    <String, dynamic>{
      'price': instance.price,
      'distanceKm': instance.distanceKm,
      'numberOfMicrobusesInQueue': instance.numberOfMicrobusesInQueue,
      'numberOfMicrobusesOnTheWay': instance.numberOfMicrobusesOnTheWay,
      'nearestArrivalMinutes': instance.nearestArrivalMinutes,
    };
