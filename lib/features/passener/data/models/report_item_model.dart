import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/report_item_entity.dart';

part 'report_item_model.g.dart';

@JsonSerializable()
class ReportItemModel {
  final String id;
  final String plateNumber;
  final String createdAt;
  final String status;

  ReportItemModel({
    required this.id,
    required this.plateNumber,
    required this.createdAt,
    required this.status,
  });

  factory ReportItemModel.fromJson(Map<String, dynamic> json) =>
      _$ReportItemModelFromJson(json);
}

extension ReportItemMapper on ReportItemModel {
  ReportItemEntity toEntity() {
    return ReportItemEntity(
      id: id,
      plateNumber: plateNumber,
      createdAt: createdAt,
      status: status,
    );
  }
}
