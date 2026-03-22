// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileModel _$ProfileModelFromJson(Map<String, dynamic> json) => ProfileModel(
  id: json['id'] as String?,
  displayName: json['displayName'] as String?,
  isActive: json['isActive'] as bool?,
  isConfirmed: json['isConfirmed'] as bool?,
  phoneNumber: json['phoneNumber'] as String?,
  role: json['roles'] as String?,
  photoUrl: json['photoUrl'] as String?,
);

Map<String, dynamic> _$ProfileModelToJson(ProfileModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'displayName': instance.displayName,
      'isActive': instance.isActive,
      'isConfirmed': instance.isConfirmed,
      'phoneNumber': instance.phoneNumber,
      'roles': instance.role,
      'photoUrl': instance.photoUrl,
    };
