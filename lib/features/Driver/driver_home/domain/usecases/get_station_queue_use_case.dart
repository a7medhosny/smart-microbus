import 'package:dartz/dartz.dart';

import '../../../../../core/error/failure.dart';
import '../entities/queue_item.dart';
import '../repository/driver_home_repository.dart';

class GetStationQueueUseCase {
  final DriverHomeRepository driverHomeRepository;

  GetStationQueueUseCase(this.driverHomeRepository);

  Future<Either<Failure, List<QueueItem>>> call({required String driverId}) {
    return driverHomeRepository.getStationQueue(driverId: driverId);
  }
}
