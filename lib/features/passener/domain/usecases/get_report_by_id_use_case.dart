import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/report.dart';
import '../repos/passenger_repo.dart';

class GetReportByIdUseCase {
  final PassengerRepo repo;

  GetReportByIdUseCase(this.repo);

  Future<Either<Failure, Report>> call(String id) async {
    return await repo.getReportById(id);
  }
}
