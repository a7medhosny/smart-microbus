import 'package:json_annotation/json_annotation.dart';
import 'package:smart_microbus/features/maps/domain/entities/nearest_station_result_entity.dart';

import 'package:smart_microbus/features/maps/domain/entities/route_info_entity.dart';

import 'location_model.dart';
import 'station_model.dart';

part 'nearest_station_result_model.g.dart';

@JsonSerializable()
class NearestStationResultModel {
  @JsonKey(name: 'stationId')
  final String stationId;

  @JsonKey(name: 'stationName')
  final String stationName;

  @JsonKey(name: 'stationCity')
  final String stationCity;

  @JsonKey(name: 'stationLat')
  final double stationLat;

  @JsonKey(name: 'stationLng')
  final double stationLng;

  final double distanceKm;
  final double etaMinutes;

  @JsonKey(name: 'points')
  final List<List<double>> points;

  NearestStationResultModel({
    required this.stationId,
    required this.stationName,
    required this.stationCity,
    required this.stationLat,
    required this.stationLng,
    required this.distanceKm,
    required this.etaMinutes,
    required this.points,
  });

  factory NearestStationResultModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$NearestStationResultModelFromJson(json);

  NearestStationResultEntity toEntity() {
    return NearestStationResultEntity(
      station: StationModel(
        id: stationId,
        name: stationName,
        city: stationCity,
        lat: stationLat,
        lng: stationLng,
      ),

      route: RouteInfoEntity(
        distanceKm: distanceKm,
        etaMinutes: etaMinutes,

        routeCoordinates:
            points
                .map(
                  (e) => LocationModel(
                    latitude: e[1],
                    longitude: e[0],
                  ).toEntity(),
                )
                .toList(),
      ),
    );
  }
}
