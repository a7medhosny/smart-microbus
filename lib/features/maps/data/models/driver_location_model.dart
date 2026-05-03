import 'package:json_annotation/json_annotation.dart';
import 'package:smart_microbus/features/maps/data/models/location_model.dart';
import 'package:smart_microbus/features/maps/domain/entities/driver_location_entity.dart';

import '../../domain/entities/location_entity.dart';

part 'driver_location_model.g.dart';

@JsonSerializable()
class DriverLocationModel {
  final String driverId;
  final DateTime lastUpdated;
  final double distance;
  final double duration;
  final List<dynamic> coordinates;

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
      coordinates: coordinates.map<LocationEntity>((e) {
        return LocationEntity(
          longitude: (e[0] as num).toDouble(),
          latitude: (e[1] as num).toDouble(),
        );
      }).toList(),
    );
  }
}
