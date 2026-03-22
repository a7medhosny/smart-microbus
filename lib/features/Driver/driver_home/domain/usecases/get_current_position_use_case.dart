import 'package:dartz/dartz.dart';
import 'package:smart_microbus/features/Driver/driver_home/domain/repository/driver_home_repository.dart';

import '../../../../../core/error/failure.dart';
import '../entities/driver_current_status.dart';

class GetCurrentPositionUsecase {
  final DriverHomeRepository driverHomeRepository;

  GetCurrentPositionUsecase(this.driverHomeRepository);

  Future<Either<Failure, DriverCurrentStatus>> call() {
    return driverHomeRepository.getCurrentPosition();
  }
}
