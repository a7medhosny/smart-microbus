import 'package:json_annotation/json_annotation.dart';
import 'package:smart_microbus/features/passener/domain/entities/report_entity.dart';
part 'report_request_body_model.g.dart';

@JsonSerializable()
class ReportRequestBodyModel extends ReportEntity {
  ReportRequestBodyModel({
    required super.plateNumber,
    required super.reasonIds,
    required super.description,
  });
  factory ReportRequestBodyModel.fromJson(Map<String, dynamic> json) =>
      _$ReportRequestBodyModelFromJson(json);
  Map<String, dynamic> toJson() => _$ReportRequestBodyModelToJson(this);
  factory ReportRequestBodyModel.fromEntity(ReportEntity entity) {
    return ReportRequestBodyModel(
      plateNumber: entity.plateNumber,
      reasonIds: entity.reasonIds,
      description: entity.description,
    );
  }
  ReportEntity toEntity() {
    return ReportEntity(
      plateNumber: plateNumber,
      reasonIds: reasonIds,
      description: description,
    );
  }
}
