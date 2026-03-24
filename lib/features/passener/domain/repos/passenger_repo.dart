import 'package:dartz/dartz.dart';
import 'package:smart_microbus/features/passener/domain/entities/station_microbus_entity.dart';

import '../../../../core/error/failure.dart';
import '../entities/destination_entity.dart';
import '../entities/on_the_way_microbus_entity.dart';
import '../entities/route_entity.dart';
import '../entities/route_summary_entity.dart';

abstract class PassengerRepo {
  Future<Either<Failure, List<PassengerRouteEntity>>> getRoutes();
  Future<Either<Failure, List<DestinationEntity>>> getRouteDestinations(
    String from,
  );
  Future<Either<Failure, RouteSummaryEntity>> getRouteSummary(String routeId);
  Future<Either<Failure, List<StationMicrobusEntity>>> getStationMicrobuses(
    String routeId,
  );
  Future<Either<Failure, List<OnTheWayMicrobusEntity>>> getOnTheWayMicrobuses(
    String routeId,
  );
  Future<Either<Failure, void>> addRouteToFavorites(String routeId);
}
