import 'package:json_annotation/json_annotation.dart';
import 'package:smart_microbus/features/passener/domain/entities/report.dart';
part 'report_model.g.dart';

@JsonSerializable()
class ReportModel extends Report {
  ReportModel({
    required super.reasons,
    required super.description,
    required super.id,
    required super.plateNumber,
    required super.createdAt,
    required super.status,
  });
  factory ReportModel.fromJson(Map<String, dynamic> json) =>
      _$ReportModelFromJson(json);
  Map<String, dynamic> toJson() => _$ReportModelToJson(this);
}
