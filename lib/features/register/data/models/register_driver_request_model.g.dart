// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_driver_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterDriverRequestModel _$RegisterDriverRequestModelFromJson(
  Map<String, dynamic> json,
) => RegisterDriverRequestModel(
  displayName: json['displayName'] as String,
  phoneNumber: json['phoneNumber'] as String,
  password: json['password'] as String,
  licenseNumber: json['licenseNumber'] as String,
);

Map<String, dynamic> _$RegisterDriverRequestModelToJson(
  RegisterDriverRequestModel instance,
) => <String, dynamic>{
  'displayName': instance.displayName,
  'phoneNumber': instance.phoneNumber,
  'password': instance.password,
  'licenseNumber': instance.licenseNumber,
};
