import '../entities/route_tracking_entity.dart';
import '../repos/passenger_repo.dart';

class ListenToRouteTrackingUseCase {
  final PassengerRepo repo;

  ListenToRouteTrackingUseCase(this.repo);

  Stream<RouteTrackingEntity> call() {
    return repo.routeTrackingStream;
  }
}
