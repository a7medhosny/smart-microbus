import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../repos/passenger_repo.dart';

class AddRouteToFavouriteUseCase {
  final PassengerRepo repo;

  AddRouteToFavouriteUseCase(this.repo);

  Future<Either<Failure, void>> call(String routeId) async {
    return repo.addRouteToFavorites(routeId);
  }
}
