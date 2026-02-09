import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/auth_response.dart';

part 'auth_response_model.g.dart';

@JsonSerializable()
class AuthResponseModel extends AuthResponse {
  AuthResponseModel({
    required super.success,
    required super.message,
    required super.statusCode,
    super.userName,
    super.token,
    super.expiration,
    super.refreshToken,
    super.refreshTokenExpirationDateTime,
  });

  factory AuthResponseModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$AuthResponseModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$AuthResponseModelToJson(this);
}
