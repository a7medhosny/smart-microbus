

import 'package:json_annotation/json_annotation.dart';
import 'package:smart_microbus/features/passener/domain/entities/station_microbus_entity.dart';

part 'station_microbus_model.g.dart';

@JsonSerializable()
class StationMicrobusModel extends StationMicrobusEntity {
   StationMicrobusModel({
    required super.passengerCount,
    @JsonKey(defaultValue: '') required super.model,
    @JsonKey(defaultValue: '') required super.color,
    required super.driverId,
    required super.driverName,
    @JsonKey(defaultValue: 0) required super.position,
    @JsonKey(defaultValue: '') required super.status,
    required super.plateNumber,
  });

  factory StationMicrobusModel.fromJson(Map<String, dynamic> json) =>
      _$StationMicrobusModelFromJson(json);

  Map<String, dynamic> toJson() => _$StationMicrobusModelToJson(this);
}