import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/report_reason_entity.dart';
import '../repos/passenger_repo.dart';

class GetReportReasonsUseCase {
  final PassengerRepo passengerRepo;

  GetReportReasonsUseCase(this.passengerRepo);

  Future<Either<Failure, List<ReportReasonEntity>>> call() {
    return passengerRepo.getReportReasons();
  }
}
