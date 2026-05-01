
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/base_response.dart';
part 'base_response_model.g.dart';

@JsonSerializable()
class BaseResponseModel extends BaseResponse {
  BaseResponseModel({required super.message, required super.statusCode});

  factory BaseResponseModel.fromJson(Map<String, dynamic> json) =>
      _$BaseResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$BaseResponseModelToJson(this);
  BaseResponse toEntity() {
    return BaseResponse(message: message, statusCode: statusCode);
  }
}
