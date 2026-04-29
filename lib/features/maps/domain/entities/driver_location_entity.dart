import 'location_entity.dart';

class DriverLocationEntity {
  final String driverId;
  final DateTime lastUpdated;
  final double distance;
  final double duration;
  final List<LocationEntity> coordinates;

  DriverLocationEntity({
    required this.driverId,
    required this.lastUpdated,
    required this.distance,
    required this.duration,
    required this.coordinates,
  });
}
