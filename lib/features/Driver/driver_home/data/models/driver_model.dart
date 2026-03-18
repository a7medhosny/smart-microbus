import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/driver.dart';

part 'driver_model.g.dart';

@JsonSerializable()
class DriverModel extends Driver {
  DriverModel({
    required super.id,
    required super.licenseNumber,
    required super.applicationUserId,
    required super.microbusId,
  });

  factory DriverModel.fromJson(Map<String, dynamic> json) =>
      _$DriverModelFromJson(json);

  Map<String, dynamic> toJson() => _$DriverModelToJson(this);
}
