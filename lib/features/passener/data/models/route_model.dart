import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/route_entity.dart';

part 'route_model.g.dart';

@JsonSerializable()
class PassengerRouteModel extends PassengerRouteEntity {
  PassengerRouteModel({required super.cityName, required super.stationId});
  factory PassengerRouteModel.fromJson(Map<String, dynamic> json) =>
      _$PassengerRouteModelFromJson(json);
  Map<String, dynamic> toJson() => _$PassengerRouteModelToJson(this);
}
