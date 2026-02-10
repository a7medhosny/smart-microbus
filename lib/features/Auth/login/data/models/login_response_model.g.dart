// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponseModel _$LoginResponseModelFromJson(Map<String, dynamic> json) =>
    LoginResponseModel(
      userName: json['userName'] as String,
      phoneNumber: json['phoneNumber'] as String,
      token: json['token'] as String,
      refreshToken: json['refreshToken'] as String,
      tokenExpiration: json['tokenExpiration'] as String,
      refreshTokenExpiration: json['refreshTokenExpiration'] as String,
    );

Map<String, dynamic> _$LoginResponseModelToJson(LoginResponseModel instance) =>
    <String, dynamic>{
      'userName': instance.userName,
      'phoneNumber': instance.phoneNumber,
      'token': instance.token,
      'refreshToken': instance.refreshToken,
      'tokenExpiration': instance.tokenExpiration,
      'refreshTokenExpiration': instance.refreshTokenExpiration,
    };
