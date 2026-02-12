import 'package:dartz/dartz.dart';
import 'package:smart_microbus/features/register/domain/repositories/register_repository.dart';

import '../../../../core/error/failure.dart';
import '../entities/verify_otp_request.dart';
import '../entities/verify_otp_response_entity.dart';

class VerifyOtpUseCase {
  final RegisterRepository registerRepoistory;

  VerifyOtpUseCase(this.registerRepoistory);

  Future<Either<Failure, VerifyOtpResponseEntity>> call(VerifyOtpRequest request) {
    return registerRepoistory.verifyOtp(request);
  }
}
