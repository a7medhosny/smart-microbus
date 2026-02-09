import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/verify_otp_request.dart';

part 'verify_otp_request_model.g.dart';

@JsonSerializable()
class VerifyOtpRequestModel extends VerifyOtpRequest {
  VerifyOtpRequestModel({
    required super.phoneNumber,
    required super.otp,
  });

  factory VerifyOtpRequestModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$VerifyOtpRequestModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$VerifyOtpRequestModelToJson(this);
}
