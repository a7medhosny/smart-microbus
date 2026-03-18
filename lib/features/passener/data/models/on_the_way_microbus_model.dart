import 'package:json_annotation/json_annotation.dart';
import 'package:smart_microbus/features/passener/domain/entities/on_the_way_microbus_entity.dart';
part 'on_the_way_microbus_model.g.dart';

@JsonSerializable()
class OnTheWayMicrobusModel extends OnTheWayMicrobusEntity {
  OnTheWayMicrobusModel({
    required super.estimatedArrivalMinutes,
    required super.passengerCount,
    required super.model,
    required super.color,
    required super.driverId,
    required super.driverName,
    required super.position,
    required super.status,
    required super.plateNumber,
  });
  factory OnTheWayMicrobusModel.fromJson(Map<String, dynamic> json) =>
      _$OnTheWayMicrobusModelFromJson(json);
  Map<String, dynamic> toJson() => _$OnTheWayMicrobusModelToJson(this);
}
