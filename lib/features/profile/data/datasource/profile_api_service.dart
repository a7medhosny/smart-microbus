import 'dart:io';

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:smart_microbus/features/passener/data/models/base_response_model.dart';

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

  @MultiPart()
  @PATCH(ApiConstants.uploadPhotoEndpoint)
  Future<BaseResponseModel> uploadUserPhoto(@Part(name: 'file') File file);

  @DELETE(ApiConstants.deleteAccountEndpoint)
  Future<BaseResponseModel> deleteAccount();

  @DELETE(ApiConstants.deletePhotoEndpoint)
  Future<BaseResponseModel> deleteProfilePhoto();
  // @POST(ApiConstants.resetPasswordEndpoint)
  // Future<void> resetPassword(@Body() ResetPasswordModel model);
}
