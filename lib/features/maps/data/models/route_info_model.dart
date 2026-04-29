import 'package:json_annotation/json_annotation.dart';

import 'package:smart_microbus/features/maps/domain/entities/route_info_entity.dart';

import 'location_model.dart';

part 'route_info_model.g.dart';

@JsonSerializable()
class RouteInfoModel {
  final double distanceKm;
  final double etaMinutes;
  final List<LocationModel> routeCoordinates;

  RouteInfoModel({
    required this.distanceKm,
    required this.etaMinutes,
    required this.routeCoordinates,
  });
  factory RouteInfoModel.fromJson(Map<String, dynamic> json) =>
      _$RouteInfoModelFromJson(json);
  Map<String, dynamic> toJson() => _$RouteInfoModelToJson(this);
  RouteInfoEntity toEntity() {
    return RouteInfoEntity(
      distanceKm: distanceKm,
      etaMinutes: etaMinutes,
      routeCoordinates: routeCoordinates.map((loc) => loc.toEntity()).toList(),
    );
  }
}
