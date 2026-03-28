import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/base_response.dart';
import '../repos/passenger_repo.dart';

class DeleteReportByIdUseCase {
  final PassengerRepo repo;

  DeleteReportByIdUseCase(this.repo);

  Future<Either<Failure, BaseResponse>> call(String id) async {
    return await repo.deleteReportById(id);
  }
}
