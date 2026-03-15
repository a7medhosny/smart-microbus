// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_history_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TripHistoryResponseModel _$TripHistoryResponseModelFromJson(
  Map<String, dynamic> json,
) => TripHistoryResponseModel(
  pageNumber: (json['pageNumber'] as num).toInt(),
  pageSize: (json['pageSize'] as num).toInt(),
  totalCount: (json['totalCount'] as num).toInt(),
  data: TripHistoryDataModel.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$TripHistoryResponseModelToJson(
  TripHistoryResponseModel instance,
) => <String, dynamic>{
  'pageNumber': instance.pageNumber,
  'pageSize': instance.pageSize,
  'totalCount': instance.totalCount,
  'data': instance.data.toJson(),
};
