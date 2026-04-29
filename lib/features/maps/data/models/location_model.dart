import 'package:json_annotation/json_annotation.dart';
import 'package:smart_microbus/features/maps/domain/entities/location_entity.dart';
part 'location_model.g.dart';

@JsonSerializable()
class LocationModel extends LocationEntity {
  LocationModel({required super.latitude, required super.longitude});
  factory LocationModel.fromJson(Map<String, dynamic> json) =>
      _$LocationModelFromJson(json);
  Map<String, dynamic> toJson() => _$LocationModelToJson(this);
  LocationEntity toEntity() {
    return LocationEntity(latitude: latitude, longitude: longitude);
  }

  factory LocationModel.fromEntity(LocationEntity entity) {
    return LocationModel(
      latitude: entity.latitude,
      longitude: entity.longitude,
    );
  }
}
