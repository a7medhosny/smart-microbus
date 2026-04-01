import 'package:dartz/dartz.dart';
import 'package:smart_microbus/features/passener/domain/repos/passenger_repo.dart';

import '../../../../core/error/failure.dart';
import '../entities/station_microbus_entity.dart';

class GetDriverByPlateNumber {
  final PassengerRepo repo;

  GetDriverByPlateNumber(this.repo);
  Future<Either<Failure, StationMicrobusEntity>> call(String plateNumber) {
    return repo.getDriverByPlateNumber(plateNumber);
  }
}
