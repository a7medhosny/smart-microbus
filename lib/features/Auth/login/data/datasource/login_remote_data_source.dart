import 'package:smart_microbus/features/Auth/login/data/models/forget_password_request_model.dart';
import 'package:smart_microbus/features/Auth/login/data/models/login_request_model.dart';
import 'package:smart_microbus/features/Auth/login/data/models/login_response_model.dart';

abstract class LoginRemoteDataSource {
  Future<LoginResponseModel> login(LoginRequestModel loginRequestModel);
  Future<LoginResponseModel> forgetPassword(
    ForgetPasswordRequestModel forgetPasswordRequestModel,
  );
}
