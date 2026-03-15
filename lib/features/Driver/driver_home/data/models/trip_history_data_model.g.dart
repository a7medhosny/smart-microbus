// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_history_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TripHistoryDataModel _$TripHistoryDataModelFromJson(
  Map<String, dynamic> json,
) => TripHistoryDataModel(
  totalAmount: (json['totalAmount'] as num).toDouble(),
  trips: (json['trips'] as List<dynamic>)
      .map((e) => TripModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$TripHistoryDataModelToJson(
  TripHistoryDataModel instance,
) => <String, dynamic>{
  'totalAmount': instance.totalAmount,
  'trips': instance.trips.map((e) => e.toJson()).toList(),
};
