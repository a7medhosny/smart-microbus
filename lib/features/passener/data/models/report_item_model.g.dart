// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportItemModel _$ReportItemModelFromJson(Map<String, dynamic> json) =>
    ReportItemModel(
      id: json['id'] as String,
      plateNumber: json['plateNumber'] as String,
      createdAt: json['createdAt'] as String,
      status: json['status'] as String,
    );

Map<String, dynamic> _$ReportItemModelToJson(ReportItemModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'plateNumber': instance.plateNumber,
      'createdAt': instance.createdAt,
      'status': instance.status,
    };
