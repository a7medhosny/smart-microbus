import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../repos/passenger_repo.dart';

class ConnectToRouteTrackingUseCase {
  final PassengerRepo repo;

  ConnectToRouteTrackingUseCase(this.repo);

  Future<Either<Failure, void>> call(String routeId) {
    return repo.connectToRouteTracking(routeId);
  }
}
