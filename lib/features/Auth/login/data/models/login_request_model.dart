import 'package:json_annotation/json_annotation.dart';
import 'package:smart_microbus/features/Auth/login/domain/entites/login_entity.dart';
part 'login_request_model.g.dart';

@JsonSerializable()
class LoginRequestModel extends LoginEntity {
  LoginRequestModel({
    required super.phoneNumber,
    required super.password,
    required super.rememberMe,
  });
  factory LoginRequestModel.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestModelFromJson(json);
  Map<String, dynamic> toJson() => _$LoginRequestModelToJson(this);

  factory LoginRequestModel.fromEntity(LoginEntity entity) {
    return LoginRequestModel(
      phoneNumber: entity.phoneNumber,
      password: entity.password,
      rememberMe: entity.rememberMe,
    );
  }
}
