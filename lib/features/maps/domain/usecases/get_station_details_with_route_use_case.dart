import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/location_entity.dart';
import '../entities/route_info_entity.dart';
import '../enums/travel_mode.dart';
import '../repos/maps_repo.dart';

class GetStationDetailsWithRouteUseCase {
  final MapsRepo mapsRepo;

  GetStationDetailsWithRouteUseCase(this.mapsRepo);

  Future<Either<Failure, RouteInfoEntity>> call({
    required String id,
    required LocationEntity location,
    TravelMode? mode,
  }) {
    return mapsRepo.getStationDetailsWithRoute(
      id: id,
      location: location,
      mode: mode,
    );
  }
}
