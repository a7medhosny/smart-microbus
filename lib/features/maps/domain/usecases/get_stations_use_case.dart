import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/station_entity.dart';
import '../repos/maps_repo.dart';

class GetStationsUseCase {
  final MapsRepo repo;

  GetStationsUseCase(this.repo);
  Future<Either<Failure, List<StationEntity>>> call() async {
    return repo.getStations();
  }
}
