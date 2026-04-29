import 'package:json_annotation/json_annotation.dart';
import 'package:smart_microbus/features/maps/data/models/location_model.dart';
import 'package:smart_microbus/features/maps/domain/entities/driver_location_entity.dart';

part 'driver_location_model.g.dart';

@JsonSerializable()
class DriverLocationModel {
  final String driverId;
  final DateTime lastUpdated;
  final double distance;
  final double duration;
  final List<LocationModel> coordinates;

  DriverLocationModel({
    required this.driverId,
    required this.lastUpdated,
    required this.distance,
    required this.duration,
    required this.coordinates,
  });
  factory DriverLocationModel.fromJson(Map<String, dynamic> json) =>
      _$DriverLocationModelFromJson(json);
  Map<String, dynamic> toJson() => _$DriverLocationModelToJson(this);
  DriverLocationEntity toEntity() {
    return DriverLocationEntity(
      driverId: driverId,
      lastUpdated: lastUpdated,
      distance: distance,
      duration: duration,
      coordinates: coordinates.map((location) => location.toEntity()).toList(),
    );
  }
}
