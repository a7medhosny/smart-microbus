import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../repos/passenger_repo.dart';

class IsRouteFavouriteUseCase {
  final PassengerRepo repo;

  IsRouteFavouriteUseCase(this.repo);

  Future<Either<Failure, bool>> call(String routeId) {
    return repo.isRouteFavorite(routeId);
  }
}
