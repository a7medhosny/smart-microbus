import 'package:dartz/dartz.dart';
import 'package:smart_microbus/features/Driver/driver_home/domain/entities/queue_event.dart';

import '../../../../../core/error/failure.dart';
import '../repository/driver_home_repository.dart';

class ListenToQueueNotificationsUseCase {
   final DriverHomeRepository driverHomeRepository;

  ListenToQueueNotificationsUseCase(this.driverHomeRepository);

  Future<Either<Failure, QueueEvent>> call() {
    return driverHomeRepository.listenToQueueNotifications();
  }
}