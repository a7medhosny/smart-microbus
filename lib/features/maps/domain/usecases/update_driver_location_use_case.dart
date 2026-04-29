import 'package:dartz/dartz.dart';
import 'package:smart_microbus/features/maps/domain/repos/maps_repo.dart';
import 'package:smart_microbus/features/passener/domain/entities/base_response.dart';

import '../../../../core/error/failure.dart';
import '../entities/location_entity.dart';

class UpdateDriverLocationUseCase {
  final MapsRepo repo;

  UpdateDriverLocationUseCase(this.repo);
  Future<Either<Failure, BaseResponse>> call(LocationEntity location) async {
    return repo.updateDriverLocation(location);
  }
}
