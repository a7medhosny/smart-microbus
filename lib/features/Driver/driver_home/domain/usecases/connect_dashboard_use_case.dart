import 'package:dartz/dartz.dart';

import '../../../../../core/error/failure.dart';
import '../repository/driver_home_repository.dart';

class ConnectDashboardUseCase {
  final DriverHomeRepository repository;

  ConnectDashboardUseCase(this.repository);

  Future<Either<Failure, Unit>> call() {
    return repository.connectToDashboard();
  }
}

