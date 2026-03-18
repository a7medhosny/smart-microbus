import 'package:dartz/dartz.dart';
import 'package:smart_microbus/core/error/failure.dart';

import '../entities/route_summary_entity.dart';
import '../repos/passenger_repo.dart';

class GetRouteSummaryUseCase {
  final PassengerRepo repo;

  GetRouteSummaryUseCase(this.repo);
  Future<Either<Failure, RouteSummaryEntity>> call(String routeId) {
    return repo.getRouteSummary(routeId);
  }
}
