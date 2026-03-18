import 'package:dartz/dartz.dart';
import 'package:smart_microbus/features/passener/domain/repos/passenger_repo.dart';

import '../../../../core/error/failure.dart';
import '../entities/station_microbus_entity.dart';

class GetStationMicrobusesUseCase {
  final PassengerRepo repo;

  GetStationMicrobusesUseCase(this.repo);
  Future<Either<Failure, List<StationMicrobusEntity>>> call(String routeId) {
    return repo.getStationMicrobuses(routeId);
  }
}
