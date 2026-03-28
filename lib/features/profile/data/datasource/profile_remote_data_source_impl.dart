import 'dart:io';

import 'package:smart_microbus/features/passener/data/models/base_response_model.dart';
import 'package:smart_microbus/features/profile/data/datasource/profile_api_service.dart';

import '../models/profile_model.dart';
import 'profile_remote_data_source.dart';

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final ProfileApiService api;

  ProfileRemoteDataSourceImpl(this.api);

  @override
  Future<ProfileModel> getProfile() {
    return api.getProfile();
  }

  @override
  Future<void> logout() {
    return api.logout();
  }

  @override
  Future<BaseResponseModel> deleteAccount() {
    return api.deleteAccount();
  }

  @override
  Future<BaseResponseModel> deleteProfilePhoto() {
    return api.deleteProfilePhoto();
  }

  @override
  Future<BaseResponseModel> uploadUserPhoto(File file) {
    return api.uploadUserPhoto(file);
  }

  // @override
  // Future<void> resetPassword(ResetPasswordModel model) {
  //   return api.resetPassword(model);
  // }
}
