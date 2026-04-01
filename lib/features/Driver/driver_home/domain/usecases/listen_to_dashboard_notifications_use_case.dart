import '../entities/dashboard_event.dart';
import '../repository/driver_home_repository.dart';

class ListenToDashboardNotificationsUseCase {
  final DriverHomeRepository repository;

  ListenToDashboardNotificationsUseCase(this.repository);

  Stream<DashboardEvent> call() {
    return repository.listenToDashboardNotifications();
  }
}