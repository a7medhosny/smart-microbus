
import 'package:dartz/dartz.dart';
import 'package:smart_microbus/features/Driver/driver_home/domain/entities/trip_history_response.dart';

import '../../../../../core/error/failure.dart';
import '../repository/driver_home_repository.dart';

class GetTripHistoryUsecase {
  final DriverHomeRepository driverHomeRepository;
  GetTripHistoryUsecase(this.driverHomeRepository);

  Future<Either<Failure, TripHistoryResponse>> call() {
    return driverHomeRepository.getTripHistory();
  }
}
