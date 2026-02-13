// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponseModel _$LoginResponseModelFromJson(Map<String, dynamic> json) =>
    LoginResponseModel(
      userName: json['userName'] as String,
      phone: json['phone'] as String,
      token: json['token'] as String,
      expiration: json['expiration'] as String,
      refreshToken: json['refreshToken'] as String,
      refreshTokenExpirationDateTime:
          json['refreshTokenExpirationDateTime'] as String,
      success: json['success'] as bool?,
      message: json['message'] as String?,
      statusCode: (json['statusCode'] as num?)?.toInt(),
    );

Map<String, dynamic> _$LoginResponseModelToJson(LoginResponseModel instance) =>
    <String, dynamic>{
      'userName': instance.userName,
      'phone': instance.phone,
      'token': instance.token,
      'expiration': instance.expiration,
      'refreshToken': instance.refreshToken,
      'refreshTokenExpirationDateTime': instance.refreshTokenExpirationDateTime,
      'success': instance.success,
      'message': instance.message,
      'statusCode': instance.statusCode,
    };
