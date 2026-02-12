import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/verify_otp_response_entity.dart';

part 'verify_otp_response_model.g.dart';

@JsonSerializable()
class VerifyOtpResponseModel extends VerifyOtpResponseEntity {
  @override
  final VerifyOtpDataModel data;

   VerifyOtpResponseModel({
    required this.data,
    required bool success,
    required String message,
  }) : super(
          data: data,
          success: success,
          message: message,
        );

  factory VerifyOtpResponseModel.fromJson(
          Map<String, dynamic> json) =>
      _$VerifyOtpResponseModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$VerifyOtpResponseModelToJson(this);
}

@JsonSerializable()
class VerifyOtpDataModel extends VerifyOtpDataEntity {
  VerifyOtpDataModel({
    required super.token,
    required super.userId,
  });

  factory VerifyOtpDataModel.fromJson(
          Map<String, dynamic> json) =>
      _$VerifyOtpDataModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$VerifyOtpDataModelToJson(this);
}
