import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../repositories/staff_repository.dart';

class CheckInUseCase {
  final StaffRepository repository;

  CheckInUseCase(this.repository);

  Future<Either<Failure, void>> call(String qrCode) {
    return repository.checkIn(qrCode);
  }
}