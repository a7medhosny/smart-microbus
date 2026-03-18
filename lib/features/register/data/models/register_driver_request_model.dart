import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/register_driver_request.dart';

part 'register_driver_request_model.g.dart';

@JsonSerializable()
class RegisterDriverRequestModel extends RegisterDriverRequest {
  RegisterDriverRequestModel({
    required super.displayName,
    required super.phoneNumber,
    required super.password,
    required super.licenseNumber,
  });

  factory RegisterDriverRequestModel.fromJson(Map<String, dynamic> json) =>
      _$RegisterDriverRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterDriverRequestModelToJson(this);
}
