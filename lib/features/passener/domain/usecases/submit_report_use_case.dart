import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/report_entity.dart';
import '../repos/passenger_repo.dart';

class SubmitReportUseCase {
  final PassengerRepo repo;

  SubmitReportUseCase(this.repo);
  Future<Either<Failure, void>> call(ReportEntity report) async {
    return repo.submitReport(report);
  }
}
