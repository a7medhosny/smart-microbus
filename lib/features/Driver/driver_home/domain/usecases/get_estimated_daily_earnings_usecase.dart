import 'package:dartz/dartz.dart';
import 'package:smart_microbus/features/Driver/driver_home/domain/repository/driver_home_repository.dart';

import '../../../../../core/error/failure.dart';
import '../entities/earning.dart';

class GetEstimatedDailyEarningsUsecase {
  final DriverHomeRepository driverHomeRepository;

  GetEstimatedDailyEarningsUsecase(this.driverHomeRepository);

  Future<Either<Failure, Earning>> call() {
    return driverHomeRepository.getEstimatedDailyEarnings();
  }
}
