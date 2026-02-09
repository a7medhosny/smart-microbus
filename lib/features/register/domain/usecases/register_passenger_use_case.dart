import 'package:dartz/dartz.dart';
import 'package:smart_microbus/features/register/domain/repositories/register_repository.dart';

import '../../../../core/error/failure.dart';
import '../entities/auth_response.dart';
import '../entities/register_passenger_request.dart';

class RegisterPassengerUseCase {
  final RegisterRepository registerRepoistory;

  RegisterPassengerUseCase(this.registerRepoistory);

  Future<Either<Failure, AuthResponse>> call(RegisterPassengerRequest request) {
    return registerRepoistory.registerPassenger(request);
  }
}
