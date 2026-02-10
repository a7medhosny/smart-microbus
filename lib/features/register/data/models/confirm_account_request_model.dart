import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/confirm_account_request.dart';

part 'confirm_account_request_model.g.dart';

@JsonSerializable()
class ConfirmAccountRequestModel extends ConfirmAccountRequest {
  ConfirmAccountRequestModel({
    required super.phoneNumber,
    required super.otp,
  });

  /// From Json
  factory ConfirmAccountRequestModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$ConfirmAccountRequestModelFromJson(json);

  /// To Json
  Map<String, dynamic> toJson() =>
      _$ConfirmAccountRequestModelToJson(this);
}
