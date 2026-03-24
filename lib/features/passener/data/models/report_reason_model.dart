import 'package:json_annotation/json_annotation.dart';
import 'package:smart_microbus/features/passener/domain/entities/report_reason_entity.dart';
part 'report_reason_model.g.dart';

@JsonSerializable()
class ReportReasonModel extends ReportReasonEntity {
  ReportReasonModel({required super.id, required super.name});
  factory ReportReasonModel.fromJson(Map<String, dynamic> json) =>
      _$ReportReasonModelFromJson(json);
  Map<String, dynamic> toJson() => _$ReportReasonModelToJson(this);
}
