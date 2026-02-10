// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'confirm_account_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConfirmAccountRequestModel _$ConfirmAccountRequestModelFromJson(
  Map<String, dynamic> json,
) => ConfirmAccountRequestModel(
  phoneNumber: json['phoneNumber'] as String,
  otp: json['otp'] as String,
);

Map<String, dynamic> _$ConfirmAccountRequestModelToJson(
  ConfirmAccountRequestModel instance,
) => <String, dynamic>{
  'phoneNumber': instance.phoneNumber,
  'otp': instance.otp,
};
