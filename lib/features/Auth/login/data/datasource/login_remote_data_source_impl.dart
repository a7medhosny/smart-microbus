import 'package:smart_microbus/features/Auth/login/data/datasource/login_api_service.dart';
import 'package:smart_microbus/features/Auth/login/data/datasource/login_remote_data_source.dart';
import 'package:smart_microbus/features/Auth/login/data/models/forget_password_request_model.dart';
import 'package:smart_microbus/features/Auth/login/data/models/login_request_model.dart';
import 'package:smart_microbus/features/Auth/login/data/models/login_response_model.dart';
import 'package:smart_microbus/features/Auth/login/data/models/reset_password_model.dart';

class LoginRemoteDataSourceImpl extends LoginRemoteDataSource {
  final LoginApiService api;

  LoginRemoteDataSourceImpl(this.api);
  @override
  Future<LoginResponseModel> login(LoginRequestModel loginRequestModel) {
    return api.login(loginRequestModel);
  }

  @override
  Future<void> forgetPassword(
    ForgetPasswordRequestModel forgetPasswordRequestModel,
  ) {
    return api.forgetPassword(forgetPasswordRequestModel);
  }

  @override
  Future<void> resetPassword(ResetPasswordModel resetPasswordModel) {
    return api.resetPassword(resetPasswordModel);
  }
}
