import 'package:dartz/dartz.dart';
import 'package:smart_microbus/features/passener/domain/repos/passenger_repo.dart';

import '../../../../core/error/failure.dart';
import '../entities/on_the_way_microbus_entity.dart';

class GetOnTheWayMicrobusesUseCase {
  final PassengerRepo repo;

  GetOnTheWayMicrobusesUseCase(this.repo);
  Future<Either<Failure, List<OnTheWayMicrobusEntity>>> call(String routeId) {
    return repo.getOnTheWayMicrobuses(routeId);
  }
}
