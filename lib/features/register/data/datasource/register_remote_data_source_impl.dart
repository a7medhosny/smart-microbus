import 'package:smart_microbus/features/register/data/datasource/register_remote_data_source.dart';

import '../models/auth_response_model.dart';
import '../models/register_driver_request_model.dart';
import '../models/register_passenger_request_model.dart';
import '../models/verify_otp_request_model.dart';
import 'register_api_service.dart';

class RegisterRemoteDataSourceImpl
    implements RegisterRemoteDataSource {
  final RegisterApiService apiService;

  RegisterRemoteDataSourceImpl(this.apiService);

  @override
  Future<AuthResponseModel> registerDriver(
    RegisterDriverRequestModel model,
  ) {
    return apiService.registerDriver(model);
  }

  @override
  Future<AuthResponseModel> registerPassenger(
    RegisterPassengerRequestModel model,
  ) {
    return apiService.registerPassenger(model);
  }

  @override
  Future<void> verifyOtp(
    VerifyOtpRequestModel model,
  ) {
    return apiService.verifyOtp(model);
  }
}
