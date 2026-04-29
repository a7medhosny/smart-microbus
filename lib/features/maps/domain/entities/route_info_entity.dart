import 'package:smart_microbus/features/maps/domain/entities/location_entity.dart';

class RouteInfoEntity {
  final double distanceKm;
  final double etaMinutes;
  final List<LocationEntity> routeCoordinates;

  RouteInfoEntity({
    required this.distanceKm,
    required this.etaMinutes,
    required this.routeCoordinates,
  });
}
