// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportModel _$ReportModelFromJson(Map<String, dynamic> json) => ReportModel(
  reasons: (json['reasons'] as List<dynamic>).map((e) => e as String).toList(),
  description: json['description'] as String,
  id: json['id'] as String,
  plateNumber: json['plateNumber'] as String,
  createdAt: json['createdAt'] as String,
  status: json['status'] as String,
);

Map<String, dynamic> _$ReportModelToJson(ReportModel instance) =>
    <String, dynamic>{
      'reasons': instance.reasons,
      'description': instance.description,
      'id': instance.id,
      'plateNumber': instance.plateNumber,
      'createdAt': instance.createdAt,
      'status': instance.status,
    };
