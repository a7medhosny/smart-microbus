import '../repos/passenger_repo.dart';

class LeaveRouteTrackingUseCase {
  final PassengerRepo repo;

  LeaveRouteTrackingUseCase(this.repo);

  Future<void> call() {
    return repo.leaveRouteTracking();
  }
}
