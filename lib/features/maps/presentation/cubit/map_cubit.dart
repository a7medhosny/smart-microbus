import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:smart_microbus/features/maps/domain/usecases/get_station_by_id_use_case.dart';
import 'package:smart_microbus/features/maps/domain/usecases/update_driver_location_use_case.dart';

import '../../domain/entities/driver_location_entity.dart';
import '../../domain/entities/location_entity.dart';
import '../../domain/entities/route_info_entity.dart';
import '../../domain/entities/station_entity.dart';
import '../../domain/enums/map_mode.dart';
import '../../domain/enums/travel_mode.dart';
import '../../domain/usecases/get_driver_location_use_case.dart';
import '../../domain/usecases/get_nearest_station_use_case.dart';
import '../../domain/usecases/get_route_between_station_use_case.dart';
import '../../domain/usecases/get_station_details_with_route_use_case.dart';
import '../../domain/usecases/get_stations_use_case.dart';

part 'map_state.dart';

class MapCubit extends Cubit<MapState> {
  final GetStationsUseCase getStationsUseCase;

  final GetNearestStationUseCase getNearestStationUseCase;

  final GetStationDetailsWithRouteUseCase getStationDetailsWithRouteUseCase;
  final UpdateDriverLocationUseCase updateDriverLocationUseCase;
  final GetRouteBetweenStationUseCase getRouteBetweenStationUseCase;
  final GetDriverLocationUseCase getDriverLocationUseCase;
  final GetStationByIdUseCase getStationByIdUseCase;
  final TextEditingController controller = TextEditingController();
  MapCubit({
    required this.getStationsUseCase,
    required this.getNearestStationUseCase,
    required this.getStationDetailsWithRouteUseCase,
    required this.getRouteBetweenStationUseCase,
    required this.getDriverLocationUseCase,
    required this.getStationByIdUseCase,
    required this.updateDriverLocationUseCase,
  }) : super(const MapState());

  StreamSubscription<Position>? positionStream;
  final MapController stationController = MapController();
  final MapController driverController = MapController();
  final MapController driverLocationController = MapController();
  DateTime? _lastUpdateTime;
  MapController get currentMapController {
    switch (state.mode) {
      case MapMode.station:
        return stationController;
      case MapMode.driver:
        return driverController;
      case MapMode.driverLocation:
        return driverLocationController;
    }
  }

  Future<void> initialize() async {
    emit(state.copyWith(loading: true, errorMessage: null));

    await _getCurrentLocation();

    await getStations();

    emit(state.copyWith(loading: false));
  }

  void moveToStation(StationEntity station) {
    currentMapController.move(LatLng(station.lat, station.lng), 14);
  }

  Future<void> _getCurrentLocation() async {
    stopLocationTracking();

    LocationPermission permission = await Geolocator.requestPermission();

    // if (permission == LocationPermission.denied ||
    //     permission == LocationPermission.deniedForever) {
    //   emit(state.copyWith(errorMessage: 'Location permission denied'));
    //   return;
    // }

    final position = await Geolocator.getCurrentPosition(
      locationSettings: AndroidSettings(
        accuracy: LocationAccuracy.bestForNavigation,
      ),
    );

    emit(state.copyWith(currentPosition: position));

    positionStream =
        Geolocator.getPositionStream(
          locationSettings: AndroidSettings(
            accuracy: LocationAccuracy.bestForNavigation,
            distanceFilter: 10,
            intervalDuration: const Duration(seconds: 2),
            foregroundNotificationConfig: const ForegroundNotificationConfig(
              notificationTitle: 'Location Tracking',
              notificationText: 'Tracking your live location',
            ),
          ),
        ).listen((position) async {
          /// =========================
          /// DEBUG
          /// =========================
          print(
            'LOCATION => '
            'lat=${position.latitude}, '
            'lng=${position.longitude}, '
            'accuracy=${position.accuracy}',
          );

          /// =========================
          /// FILTER WEAK GPS
          /// =========================

          /// تجاهل القراءات السيئة جدًا فقط
          if (position.accuracy > 50) {
            print('Weak GPS skipped');

            return;
          }

          /// =========================
          /// FILTER FAKE MOVEMENT
          /// =========================

          final oldPosition = state.currentPosition;

          if (oldPosition != null) {
            final distance = Geolocator.distanceBetween(
              oldPosition.latitude,
              oldPosition.longitude,
              position.latitude,
              position.longitude,
            );

            /// تجاهل التحرك الوهمي
            if (distance < 5) {
              print('Fake movement skipped');
              return;
            }
          }

          /// =========================
          /// UPDATE UI
          /// =========================

          emit(state.copyWith(currentPosition: position));

          /// =========================
          /// THROTTLE SERVER REQUESTS
          /// =========================

          final now = DateTime.now();

          final shouldSend =
              _lastUpdateTime == null ||
              now.difference(_lastUpdateTime!) >= const Duration(seconds: 5);

          if (!shouldSend) {
            print('Throttle skipped');
            return;
          }

          _lastUpdateTime = now;

          /// =========================
          /// STATION MODE
          /// =========================

          if (state.mode == MapMode.station && state.selectedStation != null) {
            await getStationRoute(state.selectedStation!);
          }

          /// =========================
          /// DRIVER MODE
          /// =========================

          if (state.mode == MapMode.driver && state.toStation != null) {
            /// حدث route
            await _getDriverRouteToStation(state.toStation!.id);

            /// ابعت السيرفر
            await _updateDriverLocation(position);

            print('Driver location sent');
          }
        });
  }

  Future<void> _updateDriverLocation(Position position) async {
    final result = await updateDriverLocationUseCase(
      LocationEntity(
        latitude: position.latitude,
        longitude: position.longitude,
      ),
    );

    result.fold((failure) {}, (_) {});
  }

  Future<void> getStations() async {
    final result = await getStationsUseCase();

    result.fold(
      (failure) {
        emit(state.copyWith(errorMessage: failure.message));
      },
      (stations) {
        emit(state.copyWith(stations: stations, errorMessage: null));
      },
    );
  }

  Future<void> getNearestStationRoute() async {
    if (state.currentPosition == null) return;

    emit(state.copyWith(routeLoading: true, errorMessage: null));

    final result = await getNearestStationUseCase(
      LocationEntity(
        latitude: state.currentPosition!.latitude,
        longitude: state.currentPosition!.longitude,
      ),
      state.selectedMode,
    );

    result.fold(
      (failure) {
        emit(
          state.copyWith(routeLoading: false, errorMessage: failure.message),
        );
      },
      (data) {
        moveToStation(data.station);
        emit(
          state.copyWith(
            selectedStation: data.station,
            currentRoute: data.route,
            routeLoading: false,
          ),
        );
      },
    );
  }

  Future<void> getStationRoute(StationEntity station) async {
    if (state.currentPosition == null) return;

    emit(state.copyWith(routeLoading: true, errorMessage: null));

    final result = await getStationDetailsWithRouteUseCase(
      id: station.id,
      location: LocationEntity(
        latitude: state.currentPosition!.latitude,
        longitude: state.currentPosition!.longitude,
      ),
      mode: state.selectedMode,
    );

    result.fold(
      (failure) {
        emit(
          state.copyWith(routeLoading: false, errorMessage: failure.message),
        );
      },
      (route) {
        emit(
          state.copyWith(
            currentRoute: route,
            selectedStation: station,
            routeLoading: false,
          ),
        );
      },
    );
  }

  Future<void> getRouteBetweenSelectedStations() async {
    if (state.fromStation == null || state.toStation == null) {
      return;
    }

    emit(state.copyWith(routeLoading: true, errorMessage: null));

    final result = await getRouteBetweenStationUseCase(
      fromStationId: state.fromStation!.id,
      toStationId: state.toStation!.id,
      mode: state.selectedMode,
    );

    result.fold(
      (failure) {
        emit(
          state.copyWith(routeLoading: false, errorMessage: failure.message),
        );
      },
      (route) {
        emit(state.copyWith(routeBetweenStations: route, routeLoading: false));
      },
    );
  }

  void stopLocationTracking() {
    positionStream?.cancel();
    positionStream = null;
  }

  void resetMap(MapMode mode) {
    stopLocationTracking();
    emit(MapState(mode: mode));
  }

  void updateSearchQuery(String query) {
    emit(state.copyWith(searchQuery: query));
  }

  void changeTravelMode(TravelMode mode) {
    emit(state.copyWith(selectedMode: mode));
  }

  void setFromStation(StationEntity station) {
    emit(state.copyWith(fromStation: station));
  }

  void setToStation(StationEntity station) {
    emit(state.copyWith(toStation: station));
  }

  void clearSelectedStation() {
    emit(state.copyWith(selectedStation: null, currentRoute: null));
  }

  void clearStationsRoute() {
    emit(
      state.copyWith(
        routeBetweenStations: null,
        fromStation: null,
        toStation: null,
      ),
    );
  }

  Future<void> startDriverTrip(String stationToId) async {
    emit(
      state.copyWith(
        mode: MapMode.driver,
        selectedStation: null,
        currentRoute: null,
        driverLocation: null,
      ),
    );

    final result = await getStationByIdUseCase(stationToId);

    result.fold(
      (failure) {
        emit(state.copyWith(errorMessage: failure.message));
      },
      (station) {
        emit(state.copyWith(toStation: station));
      },
    );

    await _getCurrentLocation();

    await _updateDriverLocation(state.currentPosition!);
    if (state.toStation != null) {
      await _getDriverRouteToStation(state.toStation!.id);
    }
  }

  Future<void> _getDriverRouteToStation(String stationToId) async {
    if (state.currentPosition == null) return;

    emit(state.copyWith(routeLoading: true));

    final result = await getStationDetailsWithRouteUseCase(
      id: stationToId,
      location: LocationEntity(
        latitude: state.currentPosition!.latitude,
        longitude: state.currentPosition!.longitude,
      ),
      mode: TravelMode.driving,
    );

    result.fold(
      (failure) {
        emit(
          state.copyWith(routeLoading: false, errorMessage: failure.message),
        );
      },
      (route) {
        emit(state.copyWith(currentRoute: route, routeLoading: false));
      },
    );
  }

  @override
  Future<void> close() {
    positionStream?.cancel();

    return super.close();
  }
}
