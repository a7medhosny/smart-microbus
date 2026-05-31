import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../passener/domain/entities/base_response.dart';
import '../repositories/staff_repository.dart';

class CheckOutUseCase {
  final StaffRepository repository;

  CheckOutUseCase(this.repository);

  Future<Either<Failure, BaseResponse>> call(String qrCode) {
    return repository.checkOut(qrCode);
  }
}