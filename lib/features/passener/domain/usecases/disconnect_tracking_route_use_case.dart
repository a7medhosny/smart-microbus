import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../repos/passenger_repo.dart';

class DisconnectRouteTrackingUseCase {
  final PassengerRepo repo;

  DisconnectRouteTrackingUseCase(this.repo);

  Future<Either<Failure, void>> call() {
    return repo.disconnectRouteTracking();
  }
}
