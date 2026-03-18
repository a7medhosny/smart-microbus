import 'package:dartz/dartz.dart';
import 'package:smart_microbus/core/error/failure.dart';
import '../repository/driver_home_repository.dart';

class StartTripUseCase {
  final DriverHomeRepository repository;

  StartTripUseCase(this.repository);

  Future<Either<Failure, Unit>> call({required String driverId}) {
    return repository.startTrip(driverId: driverId);
  }
}
