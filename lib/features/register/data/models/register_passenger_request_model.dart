import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/register_passenger_request.dart';

part 'register_passenger_request_model.g.dart';

@JsonSerializable()
class RegisterPassengerRequestModel extends RegisterPassengerRequest {
  RegisterPassengerRequestModel({
    required super.name,
    required super.phoneNumber,
    required super.password,
  });

  factory RegisterPassengerRequestModel.fromJson(Map<String, dynamic> json) =>
      _$RegisterPassengerRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterPassengerRequestModelToJson(this);
}
