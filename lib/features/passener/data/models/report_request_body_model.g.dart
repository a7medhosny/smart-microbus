// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_request_body_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportRequestBodyModel _$ReportRequestBodyModelFromJson(
  Map<String, dynamic> json,
) => ReportRequestBodyModel(
  plateNumber: json['plateNumber'] as String,
  reasonIds: (json['reasonIds'] as List<dynamic>)
      .map((e) => (e as num).toInt())
      .toList(),
  description: json['description'] as String?,
);

Map<String, dynamic> _$ReportRequestBodyModelToJson(
  ReportRequestBodyModel instance,
) => <String, dynamic>{
  'plateNumber': instance.plateNumber,
  'reasonIds': instance.reasonIds,
  'description': instance.description,
};
