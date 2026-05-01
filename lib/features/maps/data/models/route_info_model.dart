import 'package:json_annotation/json_annotation.dart';

import 'package:smart_microbus/features/maps/domain/entities/route_info_entity.dart';

import 'location_model.dart';

part 'route_info_model.g.dart';

@JsonSerializable()
class RouteInfoModel {
  final double distanceKm;
  final double etaMinutes;

  @JsonKey(fromJson: _pointsFromJson)
  final List<LocationModel> points;

  RouteInfoModel({
    required this.distanceKm,
    required this.etaMinutes,
    required this.points,
  });

  factory RouteInfoModel.fromJson(Map<String, dynamic> json) =>
      _$RouteInfoModelFromJson(json);

  Map<String, dynamic> toJson() => _$RouteInfoModelToJson(this);

  static List<LocationModel> _pointsFromJson(List<dynamic> json) {
    return json.map((e) {
      return LocationModel(
        longitude: (e[0] as num).toDouble(),
        latitude: (e[1] as num).toDouble(),
      );
    }).toList();
  }

  RouteInfoEntity toEntity() {
    return RouteInfoEntity(
      distanceKm: distanceKm,
      etaMinutes: etaMinutes,
      routeCoordinates: points.map((loc) => loc.toEntity()).toList(),
    );
  }
}
