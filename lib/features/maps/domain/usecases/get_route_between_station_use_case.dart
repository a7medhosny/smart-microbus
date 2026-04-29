import 'package:dartz/dartz.dart';
import 'package:smart_microbus/features/maps/domain/repos/maps_repo.dart';

import '../../../../core/error/failure.dart';

import '../entities/route_info_entity.dart';
import '../enums/travel_mode.dart';

class GetRouteBetweenStationUseCase {
  final MapsRepo repo;

  GetRouteBetweenStationUseCase(this.repo);
  Future<Either<Failure, RouteInfoEntity>> call({
    required String fromStationId,
    required String toStationId,
    TravelMode? mode,
  }) async {
    return repo.getRouteBetweenStation(
      fromStationId: fromStationId,
      toStationId: toStationId,
      mode: mode,
    );
  }
}
