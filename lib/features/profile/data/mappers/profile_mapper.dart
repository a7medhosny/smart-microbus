import '../../domain/entities/profile.dart';
import '../models/profile_model.dart';

extension ProfileMapper on ProfileModel {
  Profile toEntity() {
    return Profile(
      id: id ?? '',
      name: displayName ?? '---',
      phone: phoneNumber ?? '',
      role: role ?? 'user',
      isActive: isActive ?? false,
      photoUrl: photoUrl ?? '',
    );
  }
}
