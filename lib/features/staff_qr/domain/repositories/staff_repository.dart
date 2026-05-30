import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';

abstract class StaffRepository {
    Future<Either<Failure, void>> checkIn(String qrCode);

  Future<Either<Failure, void>> checkOut(String qrCode);
}