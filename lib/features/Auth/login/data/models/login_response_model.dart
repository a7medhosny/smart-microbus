import 'package:json_annotation/json_annotation.dart';

import 'package:smart_microbus/features/Auth/login/domain/entites/user_entity.dart';
part 'login_response_model.g.dart';

@JsonSerializable()
class LoginResponseModel extends UserEntity {
  LoginResponseModel({
    required super.userName,
    required super.phoneNumber,
    required super.token,
    required super.refreshToken,
    required super.tokenExpiration,
    required super.refreshTokenExpiration,
  });
  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$LoginResponseModelToJson(this);
}
