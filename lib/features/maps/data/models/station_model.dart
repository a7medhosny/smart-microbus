import 'package:json_annotation/json_annotation.dart';
import 'package:smart_microbus/features/maps/domain/entities/station_entity.dart';
part 'station_model.g.dart';

@JsonSerializable()
class StationModel extends StationEntity {
  StationModel({
    required super.id,
    required super.name,
    required super.city,
    required super.lat,
    required super.lng,
  });
  factory StationModel.fromJson(Map<String, dynamic> json) =>
      _$StationModelFromJson(json);
  Map<String, dynamic> toJson() => _$StationModelToJson(this);
}
