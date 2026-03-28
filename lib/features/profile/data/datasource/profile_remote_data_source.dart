import 'dart:io';

import 'package:smart_microbus/features/passener/data/models/base_response_model.dart';

import '../models/profile_model.dart';

abstract class ProfileRemoteDataSource {
  Future<ProfileModel> getProfile();
  Future<void> logout();
  Future<BaseResponseModel> deleteAccount();
  Future<BaseResponseModel> deleteProfilePhoto();
  Future<BaseResponseModel> uploadUserPhoto(File filePath);
  // Future<void> resetPassword(ResetPasswordModel model);
}
