// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'earning_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EarningModel _$EarningModelFromJson(Map<String, dynamic> json) => EarningModel(
  date: DateTime.parse(json['date'] as String),
  totalTrips: (json['totalTrips'] as num).toInt(),
  totalPassengers: (json['totalPassengers'] as num).toInt(),
  totalDistanceKm: (json['totalDistanceKm'] as num).toDouble(),
  totalEarnings: (json['totalEarnings'] as num).toDouble(),
  currency: json['currency'] as String,
  averagePerTrip: (json['averagePerTrip'] as num).toDouble(),
  lastUpdated: DateTime.parse(json['lastUpdated'] as String),
);

Map<String, dynamic> _$EarningModelToJson(EarningModel instance) =>
    <String, dynamic>{
      'date': instance.date.toIso8601String(),
      'totalTrips': instance.totalTrips,
      'totalPassengers': instance.totalPassengers,
      'totalDistanceKm': instance.totalDistanceKm,
      'totalEarnings': instance.totalEarnings,
      'currency': instance.currency,
      'averagePerTrip': instance.averagePerTrip,
      'lastUpdated': instance.lastUpdated.toIso8601String(),
    };
