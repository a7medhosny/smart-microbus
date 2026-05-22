import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../maps/domain/entities/driver_location_entity.dart';

abstract class PassengerLocationRepo {
  Stream<DriverLocationEntity> get locationStream;

  Future<Either<Failure, void>> connect(String driverId);

  Future<Either<Failure, void>> disconnect();

  Future<void> leaveDriver();
}
