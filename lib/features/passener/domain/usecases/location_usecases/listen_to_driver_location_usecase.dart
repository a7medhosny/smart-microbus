import '../../../../maps/domain/entities/driver_location_entity.dart';
import '../../repos/passenger_location_repo.dart';

class ListenToDriverLocationUseCase {
  final PassengerLocationRepo repo;

  ListenToDriverLocationUseCase(this.repo);

  Stream<DriverLocationEntity> call() {
    return repo.locationStream;
  }
}