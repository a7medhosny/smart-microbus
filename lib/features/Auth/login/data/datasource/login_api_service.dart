import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:smart_microbus/core/networking/api_constants.dart';
import 'package:smart_microbus/features/Auth/login/data/models/forget_password_request_model.dart';
import 'package:smart_microbus/features/Auth/login/data/models/login_request_model.dart';
import 'package:smart_microbus/features/Auth/login/data/models/login_response_model.dart';
import 'package:smart_microbus/features/Auth/login/data/models/reset_password_model.dart';

part 'login_api_service.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class LoginApiService {
  factory LoginApiService(Dio dio, {String baseUrl}) = _LoginApiService;
  @POST(ApiConstants.loginEndpoint)
  Future<LoginResponseModel> login(@Body() LoginRequestModel loginRequest);
  @POST(ApiConstants.forgotPasswordEndpoint)
  Future<void> forgetPassword(
    @Body() ForgetPasswordRequestModel forgetPasswordRequest,
  );
  //POST /api/v1/Account/reset-password
  @POST(ApiConstants.resetPasswordEndpoint)
  Future<void> resetPassword(@Body() ResetPasswordModel resetPasswordModel);
}
