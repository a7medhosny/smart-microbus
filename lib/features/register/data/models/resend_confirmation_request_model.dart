import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/resend_confirmation_request.dart';

part 'resend_confirmation_request_model.g.dart';

@JsonSerializable()
class ResendConfirmationRequestModel extends ResendConfirmationRequest {
  ResendConfirmationRequestModel({required super.phoneNumber});

  /// From Json
  factory ResendConfirmationRequestModel.fromJson(Map<String, dynamic> json) =>
      _$ResendConfirmationRequestModelFromJson(json);

  /// To Json
  Map<String, dynamic> toJson() => _$ResendConfirmationRequestModelToJson(this);
}
