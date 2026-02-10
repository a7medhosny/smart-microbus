import 'package:dartz/dartz.dart';
import 'package:smart_microbus/features/register/domain/repositories/register_repository.dart';

import '../../../../core/error/failure.dart';
import '../entities/auth_response.dart';
import '../entities/confirm_account_request.dart';

class ConfirmAccountUseCase {
  final RegisterRepository registerRepoistory;

  ConfirmAccountUseCase(this.registerRepoistory);

  Future<Either<Failure, AuthResponse>> call(ConfirmAccountRequest request) {
    return registerRepoistory.confirmAccount(request);
  }
}
