import 'package:dartz/dartz.dart';
import 'package:smart_microbus/features/Driver/driver_home/domain/entities/trip_history_response.dart';

import '../../../../../core/error/failure.dart';
import '../repository/driver_home_repository.dart';

class GetTripHistoryUseCase {
  final DriverHomeRepository driverHomeRepository;

  GetTripHistoryUseCase(this.driverHomeRepository);

  Future<Either<Failure, TripHistoryResponse>> call({
    DateTime? fromDate,
    DateTime? toDate,
    int? pageSize,
    int? pageNumber,
  }) {
    return driverHomeRepository.getTripHistory(
      fromDate: fromDate,
      toDate: toDate,
      pageSize: pageSize,
      pageNumber: pageNumber,
    );
  }
}
