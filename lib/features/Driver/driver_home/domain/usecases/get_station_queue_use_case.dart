import 'package:dartz/dartz.dart';
import 'package:smart_microbus/features/Driver/driver_home/domain/entities/queue.dart';

import '../../../../../core/error/failure.dart';
import '../repository/driver_home_repository.dart';

class GetStationQueueUseCase {
  final DriverHomeRepository driverHomeRepository;

  GetStationQueueUseCase(this.driverHomeRepository);

  Future<Either<Failure, QueueResponse>> call({
    required String stationId,
    required String routeId,
  }) {
    return driverHomeRepository.getStationQueue(
      stationId: stationId,
      routeId: routeId,
    );
  }
}
