import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../repositories/staff_repository.dart';

class CheckOutUseCase {
  final StaffRepository repository;

  CheckOutUseCase(this.repository);

  Future<Either<Failure, void>> call(String qrCode) {
    return repository.checkOut(qrCode);
  }
}