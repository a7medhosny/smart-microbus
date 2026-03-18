import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:smart_microbus/features/register/data/models/verify_otp_response_model.dart';

import '../../../../core/networking/api_constants.dart';
import '../models/auth_response_model.dart';
import '../models/confirm_account_request_model.dart';
import '../models/refresh_token_request_model.dart';
import '../models/register_driver_request_model.dart';
import '../models/register_passenger_request_model.dart';
import '../models/resend_confirmation_request_model.dart';
import '../models/verify_otp_request_model.dart';

part 'register_api_service.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class RegisterApiService {
  factory RegisterApiService(Dio dio, {String baseUrl}) = _RegisterApiService;

  // -------------------- REGISTER DRIVER --------------------

  @POST(ApiConstants.registerDriverEndpoint)
  Future<AuthResponseModel> registerDriver(
    @Body() RegisterDriverRequestModel model,
  );

  // -------------------- REGISTER PASSENGER --------------------

  @POST(ApiConstants.registerPassengerEndpoint)
  Future<AuthResponseModel> registerPassenger(
    @Body() RegisterPassengerRequestModel model,
  );

  // -------------------- VERIFY OTP --------------------

  @POST(ApiConstants.verifyOtpEndpoint)
  Future<VerifyOtpResponseModel> verifyOtp(@Body() VerifyOtpRequestModel model);

  // -------------------- CONFIRM ACCOUNT --------------------

  @POST(ApiConstants.confirmAccountEndpoint)
  Future<AuthResponseModel> confirmAccount(
    @Body() ConfirmAccountRequestModel model,
  );

  // -------------------- RESEND CONFIRMATION --------------------

  @POST(ApiConstants.resendConfirmationEndpoint)
  Future<AuthResponseModel> resendConfirmation(
    @Body() ResendConfirmationRequestModel model,
  );

  @POST(ApiConstants.refreshTokenEndpoint)
  Future<AuthResponseModel> refreshToken(
    @Body() RefreshTokenRequestModel request,
  );
}
