import 'package:dartz/dartz.dart';
import 'package:smart_microbus/features/passener/domain/repos/passenger_repo.dart';

import '../../../../core/error/failure.dart';
import '../entities/destination_entity.dart';

class GetRouteDestinationUseCase {
  final PassengerRepo repo;

  GetRouteDestinationUseCase(this.repo);
  Future<Either<Failure, List<DestinationEntity>>> call(String from) {
    return repo.getRouteDestinations(from);
  }
}
