import 'package:dartz/dartz.dart';

import '../../../../../core/error/failure.dart';
import '../../entities/base_response.dart';
import '../../repos/passenger_location_repo.dart';

class ConnectToDriverLocationUseCase {
  final PassengerLocationRepo repo;

  ConnectToDriverLocationUseCase(this.repo);

  Future<Either<Failure, void>> call(String driverId) {
    return repo.connect(driverId);
  }
}