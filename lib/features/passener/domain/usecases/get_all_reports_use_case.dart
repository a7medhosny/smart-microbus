import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/all_report_request_entity.dart';
import '../entities/all_report_response_entity.dart';
import '../repos/passenger_repo.dart';

class GetAllReportsUseCase {
  final PassengerRepo repo;

  GetAllReportsUseCase(this.repo);

  Future<Either<Failure, AllReportResponseEntity>> call({
    AllrportRequestEntity? requestEntity,
  }) async {
    return await repo.getAllReports(requestEntity);
  }
}
