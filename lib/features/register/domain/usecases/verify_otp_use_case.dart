import 'package:dartz/dartz.dart';
import 'package:smart_microbus/features/register/domain/repositories/register_repoistory.dart';

import '../../../../core/error/failure.dart';
import '../entities/verify_otp_request.dart';

class VerifyOtpUseCase {
  final RegisterRepoistory registerRepoistory;

  VerifyOtpUseCase(this.registerRepoistory);

  Future<Either<Failure, void>> call(
    VerifyOtpRequest request,
  ) {
    return registerRepoistory.verifyOtp(request);
  }
}
