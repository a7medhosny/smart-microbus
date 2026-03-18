import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/refresh_token_request.dart';

part 'refresh_token_request_model.g.dart';

@JsonSerializable()
class RefreshTokenRequestModel extends RefreshTokenRequest {
  RefreshTokenRequestModel({required super.token, required super.refreshToken});

  factory RefreshTokenRequestModel.fromJson(Map<String, dynamic> json) =>
      _$RefreshTokenRequestModelFromJson(json);
  Map<String, dynamic> toJson() => _$RefreshTokenRequestModelToJson(this);
}
