import 'package:dartz/dartz.dart';
import 'package:smart_microbus/core/error/failure.dart';
import '../repository/driver_home_repository.dart';

class EndTripUseCase {
  final DriverHomeRepository repository;

  EndTripUseCase(this.repository);

  Future<Either<Failure, Unit>> call({
    required String driverId,
  }) {
    return repository.endTrip(driverId: driverId);
  }
}