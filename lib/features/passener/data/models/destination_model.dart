import 'package:json_annotation/json_annotation.dart';
import 'package:smart_microbus/features/passener/domain/entities/destination_entity.dart';
part 'destination_model.g.dart';

@JsonSerializable()
class DestinationModel extends DestinationEntity {
  DestinationModel({required super.routeId, required super.to, required super.stationId});
  factory DestinationModel.fromJson(Map<String, dynamic> json) =>
      _$DestinationModelFromJson(json);
  Map<String, dynamic> toJson() => _$DestinationModelToJson(this);
}
