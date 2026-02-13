import 'package:smart_microbus/features/Auth/login/data/models/forget_password_request_model.dart';
import 'package:smart_microbus/features/Auth/login/data/models/login_request_model.dart';
import 'package:smart_microbus/features/Auth/login/data/models/login_response_model.dart';
import 'package:smart_microbus/features/Auth/login/data/models/reset_password_model.dart';

abstract class LoginRemoteDataSource {
  Future<LoginResponseModel> login(LoginRequestModel loginRequestModel);
  Future<void> forgetPassword(
    ForgetPasswordRequestModel forgetPasswordRequestModel,
  );
  Future<void> resetPassword(ResetPasswordModel resetPasswordModel);
}
