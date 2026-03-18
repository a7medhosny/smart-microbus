// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TripModel _$TripModelFromJson(Map<String, dynamic> json) => TripModel(
  amount: (json['amount'] as num).toDouble(),
  routeFrom: json['routeFrom'] as String,
  routeTo: json['routeTo'] as String,
  startedAt: DateTime.parse(json['startedAt'] as String),
  endedAt: DateTime.parse(json['endedAt'] as String),
  passengerCount: (json['passengerCount'] as num).toInt(),
  distance: (json['distance'] as num).toDouble(),
  status: (json['status'] as num).toInt(),
  estimatedArrivalMinutes: (json['estimatedArrivalMinutes'] as num).toDouble(),
);

Map<String, dynamic> _$TripModelToJson(TripModel instance) => <String, dynamic>{
  'amount': instance.amount,
  'routeFrom': instance.routeFrom,
  'routeTo': instance.routeTo,
  'startedAt': instance.startedAt.toIso8601String(),
  'endedAt': instance.endedAt.toIso8601String(),
  'passengerCount': instance.passengerCount,
  'distance': instance.distance,
  'estimatedArrivalMinutes': instance.estimatedArrivalMinutes,
  'status': instance.status,
};
