// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_passenger_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterPassengerRequestModel _$RegisterPassengerRequestModelFromJson(
  Map<String, dynamic> json,
) => RegisterPassengerRequestModel(
  name: json['name'] as String,
  phoneNumber: json['phoneNumber'] as String,
  password: json['password'] as String,
);

Map<String, dynamic> _$RegisterPassengerRequestModelToJson(
  RegisterPassengerRequestModel instance,
) => <String, dynamic>{
  'name': instance.name,
  'phoneNumber': instance.phoneNumber,
  'password': instance.password,
};
