import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';

import '../entities/route_entity.dart';
import '../repos/passenger_repo.dart';

class GetRoutesUseCase {
  final PassengerRepo passengerRepo;

  GetRoutesUseCase(this.passengerRepo);
  Future<Either<Failure, List<PassengerRouteEntity>>> call()   {
    return passengerRepo.getRoutes();
  }
}
