import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/base_response.dart';
import '../repos/passenger_repo.dart';

class RemoveRouteFromFavUseCase {
  final PassengerRepo repo;

  RemoveRouteFromFavUseCase(this.repo);
  Future<Either<Failure, BaseResponse>> call(String routeId) async {
    return repo.removeRouteFromFavorites(routeId);
  }
}
