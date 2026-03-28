// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_report_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllReportResponseModel _$AllReportResponseModelFromJson(
  Map<String, dynamic> json,
) => AllReportResponseModel(
  items: (json['items'] as List<dynamic>)
      .map((e) => ReportItemModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  totalCount: (json['totalCount'] as num).toInt(),
  pageNumber: (json['pageNumber'] as num).toInt(),
  pageSize: (json['pageSize'] as num).toInt(),
);

Map<String, dynamic> _$AllReportResponseModelToJson(
  AllReportResponseModel instance,
) => <String, dynamic>{
  'items': instance.items,
  'totalCount': instance.totalCount,
  'pageNumber': instance.pageNumber,
  'pageSize': instance.pageSize,
};
