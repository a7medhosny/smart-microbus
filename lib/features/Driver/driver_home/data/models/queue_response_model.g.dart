// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'queue_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QueueResponseModel _$QueueResponseModelFromJson(Map<String, dynamic> json) =>
    QueueResponseModel(
      id: json['id'] as String,
      stationId: json['stationId'] as String,
      routeId: json['routeId'] as String,
      items: (json['items'] as List<dynamic>)
          .map((e) => QueueItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$QueueResponseModelToJson(QueueResponseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'stationId': instance.stationId,
      'routeId': instance.routeId,
      'items': instance.items.map((e) => e.toJson()).toList(),
    };
