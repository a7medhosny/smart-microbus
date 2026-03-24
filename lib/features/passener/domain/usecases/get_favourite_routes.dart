import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/favourite_route_entity.dart';
import '../repos/passenger_repo.dart';

class GetFavouriteRoutes {
  final PassengerRepo repo;

  GetFavouriteRoutes(this.repo);

  Future<Either<Failure, List<FavouriteRouteEntity>>> call() async {
    return repo.getFavoriteRoutes();
  }
}
