import 'package:dartz/dartz.dart';
import 'package:smart_microbus/features/Driver/driver_home/domain/repository/driver_home_repository.dart';

import '../../../../../core/error/failure.dart';
import '../entities/queue_item.dart';

class GetCurrentPositionUsecase {
  final DriverHomeRepository driverHomeRepository;

  GetCurrentPositionUsecase(this.driverHomeRepository);

  Future<Either<Failure, QueueItem>> call() {
    return driverHomeRepository.getCurrentPosition();
  }
}
