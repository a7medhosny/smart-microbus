import 'package:dio/dio.dart' ;
import 'package:retrofit/retrofit.dart';

import '../../../../core/networking/api_constants.dart';
import '../models/profile_model.dart';

part 'profile_api_service.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class ProfileApiService {
  factory ProfileApiService(Dio dio, {String baseUrl}) = _ProfileApiService;

  @GET(ApiConstants.myProfileEndpoint)
  Future<ProfileModel> getProfile();

  @POST(ApiConstants.logoutEndpoint)
  Future<void> logout();

  // @POST(ApiConstants.resetPasswordEndpoint)
  // Future<void> resetPassword(@Body() ResetPasswordModel model);
}