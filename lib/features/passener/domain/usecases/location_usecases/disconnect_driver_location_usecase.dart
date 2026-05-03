import 'package:dartz/dartz.dart';

import '../../../../../core/error/failure.dart';
import '../../entities/base_response.dart';
import '../../repos/passenger_location_repo.dart';

class DisconnectDriverLocationUseCase {
  final PassengerLocationRepo repo;

  DisconnectDriverLocationUseCase(this.repo);

  Future<Either<Failure, void>> call() {
    return repo.disconnect();
  }
}