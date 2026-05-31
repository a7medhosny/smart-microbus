import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../passener/domain/entities/base_response.dart';
import '../repositories/staff_repository.dart';

class CheckInUseCase {
  final StaffRepository repository;

  CheckInUseCase(this.repository);

  Future<Either<Failure, BaseResponse>> call(String qrCode) {
    return repository.checkIn(qrCode);
  }
}