import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../passener/domain/entities/base_response.dart';
import '../entities/driver_location_entity.dart' show DriverLocationEntity;
import '../entities/location_entity.dart';
import '../entities/route_info_entity.dart';
import '../entities/station_entity.dart';
import '../enums/travel_mode.dart';

abstract class MapsRepo {
  Future<Either<Failure, BaseResponse>> updateDriverLocation(
    LocationEntity location,
  );
  Future<Either<Failure, DriverLocationEntity>> getDriverLocation(
    String driverId,
  );
  Future<Either<Failure, RouteInfoEntity>> getNearestStation({
    required LocationEntity location,
    TravelMode? mode,
  });
  Future<Either<Failure, List<StationEntity>>> getStations();
  Future<Either<Failure, StationEntity>> getStationById(String id);
  Future<Either<Failure, RouteInfoEntity>> getRouteBetweenStation({
    required String fromStationId,
    required String toStationId,
    TravelMode? mode,
  });
  Future<Either<Failure, RouteInfoEntity>> getStationDetailsWithRoute({
    required String id,
    required LocationEntity location,
    TravelMode? mode,
  });
}
