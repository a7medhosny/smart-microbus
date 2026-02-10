import 'package:json_annotation/json_annotation.dart';
import 'package:smart_microbus/features/Auth/login/domain/entites/forget_password_entity.dart';
part 'forget_password_request_model.g.dart';

@JsonSerializable()
class ForgetPasswordRequestModel extends ForgetPasswordEntity {
  ForgetPasswordRequestModel({required super.phoneNumber});
  factory ForgetPasswordRequestModel.fromJson(Map<String, dynamic> json) =>
      _$ForgetPasswordRequestModelFromJson(json);
  Map<String, dynamic> toJson() => _$ForgetPasswordRequestModelToJson(this);
  factory ForgetPasswordRequestModel.fromEntity(
    ForgetPasswordEntity forgetPasswordEntity,
  ) {
    return ForgetPasswordRequestModel(
      phoneNumber: forgetPasswordEntity.phoneNumber,
    );
  }
}
