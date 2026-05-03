

import '../../../maps/domain/entities/driver_location_entity.dart';

abstract class PassengerLocationDataSource {
  Stream<DriverLocationEntity> get locationStream;

  Future<void> connect(String driverId);

  Future<void> disconnect();

  Future<void> leaveDriver();

  Future<void> refreshConnection();
}