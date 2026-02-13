import 'package:json_annotation/json_annotation.dart';
import 'package:smart_microbus/features/Auth/login/domain/entites/reset_password_entity.dart';
part 'reset_password_model.g.dart';

@JsonSerializable()
class ResetPasswordModel extends ResetPasswordEntity {
  ResetPasswordModel({
    required super.userId,
    required super.token,
    required super.newPassword,
    required super.confirmPassword,
  });
  factory ResetPasswordModel.fromJson(Map<String, dynamic> json) =>
      _$ResetPasswordModelFromJson(json);
  Map<String, dynamic> toJson() => _$ResetPasswordModelToJson(this);
  factory ResetPasswordModel.fromEntity(ResetPasswordEntity entity) {
    return ResetPasswordModel(
      userId: entity.userId,
      token: entity.token,
      newPassword: entity.newPassword,
      confirmPassword: entity.confirmPassword,
    );
  }
}
