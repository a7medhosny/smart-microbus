// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_otp_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifyOtpResponseModel _$VerifyOtpResponseModelFromJson(
  Map<String, dynamic> json,
) => VerifyOtpResponseModel(
  data: VerifyOtpDataModel.fromJson(json['data'] as Map<String, dynamic>),
  success: json['success'] as bool,
  message: json['message'] as String,
);

Map<String, dynamic> _$VerifyOtpResponseModelToJson(
  VerifyOtpResponseModel instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
  'data': instance.data,
};

VerifyOtpDataModel _$VerifyOtpDataModelFromJson(Map<String, dynamic> json) =>
    VerifyOtpDataModel(
      token: json['token'] as String,
      userId: json['userId'] as String,
    );

Map<String, dynamic> _$VerifyOtpDataModelToJson(VerifyOtpDataModel instance) =>
    <String, dynamic>{'token': instance.token, 'userId': instance.userId};
