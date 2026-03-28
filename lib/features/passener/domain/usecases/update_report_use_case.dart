import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/base_response.dart';
import '../entities/report_entity.dart';
import '../repos/passenger_repo.dart';

class UpdateReportUseCase {
  final PassengerRepo repository;

  UpdateReportUseCase(this.repository);

  Future<Either<Failure, BaseResponse>> call(
    String id,
    ReportEntity report,
  ) async {
    return await repository.updateReport(id, report);
  }
}
