import '../entities/queue_event.dart';
import '../repository/driver_home_repository.dart';

class ListenToQueueNotificationsUseCase {
  final DriverHomeRepository driverHomeRepository;

  ListenToQueueNotificationsUseCase(this.driverHomeRepository);

  Stream<QueueEvent> call() {
    return driverHomeRepository.listenToQueueNotifications();
  }
}
