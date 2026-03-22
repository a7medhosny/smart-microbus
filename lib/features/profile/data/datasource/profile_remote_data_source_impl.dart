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
  
  // @override
  // Future<void> resetPassword(ResetPasswordModel model) {
  //   return api.resetPassword(model);
  // }
}