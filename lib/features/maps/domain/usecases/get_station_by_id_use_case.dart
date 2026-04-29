import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/station_entity.dart';
import '../repos/maps_repo.dart';

class GetStationByIdUseCase {
  final MapsRepo repo;

  GetStationByIdUseCase(this.repo);
  Future<Either<Failure, StationEntity>> call(String id) async {
    return repo.getStationById(id);
  }
}
