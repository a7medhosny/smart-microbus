import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/all_report_response_entity.dart';
import '../../domain/entities/report_item_entity.dart';
import 'report_item_model.dart';

part 'all_report_response_model.g.dart';

@JsonSerializable()
class AllReportResponseModel {
  final List<ReportItemModel> items;
  final int totalCount;
  final int pageNumber;
  final int pageSize;

  AllReportResponseModel({
    required this.items,
    required this.totalCount,
    required this.pageNumber,
    required this.pageSize,
  });

  factory AllReportResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AllReportResponseModelFromJson(json);
}

extension AllReportMapper on AllReportResponseModel {
  AllReportResponseEntity toEntity() {
    return AllReportResponseEntity(
      items: items.map((e) => e.toEntity()).toList(),
      totalCount: totalCount,
      pageNumber: pageNumber,
      pageSize: pageSize,
    );
  }
}
