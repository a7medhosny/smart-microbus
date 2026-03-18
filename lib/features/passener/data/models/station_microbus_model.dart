import 'package:json_annotation/json_annotation.dart';
import 'package:smart_microbus/features/passener/domain/entities/station_microbus_entity.dart';
part 'station_microbus_model.g.dart';

@JsonSerializable()
class StationMicrobusModel extends StationMicrobusEntity {
  StationMicrobusModel({
    required super.passengerCount,
    required super.model,
    required super.color,
    required super.driverId,
    required super.driverName,
    required super.position,
    required super.status,
    required super.plateNumber,
  });
  factory StationMicrobusModel.fromJson(Map<String, dynamic> json) =>
      _$StationMicrobusModelFromJson(json);
  Map<String, dynamic> toJson() => _$StationMicrobusModelToJson(this);
}
