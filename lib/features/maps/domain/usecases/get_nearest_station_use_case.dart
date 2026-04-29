import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/location_entity.dart';
import '../entities/route_info_entity.dart';
import '../enums/travel_mode.dart';
import '../repos/maps_repo.dart';

class GetNearestStationUseCase {
  final MapsRepo repo;

  GetNearestStationUseCase(this.repo);
  Future<Either<Failure, RouteInfoEntity>> call(
    LocationEntity location,
    TravelMode? mode,
  ) async {
    return repo.getNearestStation(location: location, mode: mode);
  }
}
