import 'route_info_entity.dart';
import 'station_entity.dart';

class NearestStationResultEntity {
  final StationEntity station;
  final RouteInfoEntity route;

  NearestStationResultEntity({
    required this.station,
    required this.route,
  });
}