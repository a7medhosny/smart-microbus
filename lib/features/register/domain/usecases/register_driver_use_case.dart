import 'package:dartz/dartz.dart';
import 'package:smart_microbus/features/register/domain/repositories/register_repoistory.dart';

import '../../../../core/error/failure.dart';
import '../entities/auth_response.dart';
import '../entities/register_driver_request.dart';

class RegisterDriverUseCase {
  final RegisterRepoistory registerRepoistory;

  RegisterDriverUseCase(this.registerRepoistory);
  Future<Either<Failure, AuthResponse>> call(RegisterDriverRequest request) {
    return registerRepoistory.registerDriver(request);
  }
}
