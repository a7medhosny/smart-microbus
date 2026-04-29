import 'package:dartz/dartz.dart';
import 'package:smart_microbus/core/error/failure.dart';
import 'package:smart_microbus/features/maps/domain/entities/driver_location_entity.dart';
import 'package:smart_microbus/features/maps/domain/repos/maps_repo.dart';

class GetDriverLocationUseCase {
  final MapsRepo repo;

  GetDriverLocationUseCase(this.repo);
  Future<Either<Failure, DriverLocationEntity>> call(String driverId) async {
    return repo.getDriverLocation(driverId);
  }
}
