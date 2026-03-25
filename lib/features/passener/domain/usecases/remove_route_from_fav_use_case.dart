import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../repos/passenger_repo.dart';

class RemoveRouteFromFavUseCase {
  final PassengerRepo repo;

  RemoveRouteFromFavUseCase(this.repo);
  Future<Either<Failure, String>> call(String routeId) async {
    return repo.removeRouteFromFavorites(routeId);
  }
}
