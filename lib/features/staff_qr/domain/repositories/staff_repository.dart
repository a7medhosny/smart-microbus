import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../passener/domain/entities/base_response.dart';

abstract class StaffRepository {
    Future<Either<Failure, BaseResponse>> checkIn(String qrCode);

  Future<Either<Failure, BaseResponse>> checkOut(String qrCode);
}