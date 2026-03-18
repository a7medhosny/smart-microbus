import 'package:dartz/dartz.dart';
import 'package:smart_microbus/features/register/domain/repositories/register_repository.dart';

import '../../../../core/error/failure.dart';
import '../entities/auth_response.dart';
import '../entities/resend_confirmation_request.dart';

class ResendConfirmationUseCase {
  final RegisterRepository registerRepoistory;

  ResendConfirmationUseCase(this.registerRepoistory);

  Future<Either<Failure, AuthResponse>> call(
    ResendConfirmationRequest request,
  ) {
    return registerRepoistory.resendConfirmation(request);
  }
}
