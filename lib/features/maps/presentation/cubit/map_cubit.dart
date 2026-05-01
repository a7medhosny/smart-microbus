import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

import '../../domain/entities/location_entity.dart';
import '../../domain/entities/route_info_entity.dart';
import '../../domain/entities/station_entity.dart';
import '../../domain/enums/travel_mode.dart';
import '../../domain/usecases/get_nearest_station_use_case.dart';
import '../../domain/usecases/get_route_between_station_use_case.dart';
import '../../domain/usecases/get_station_details_with_route_use_case.dart';
import '../../domain/usecases/get_stations_use_case.dart';

part 'map_state.dart';

class MapCubit extends Cubit<MapState> {
  final GetStationsUseCase getStationsUseCase;

  final GetNearestStationUseCase getNearestStationUseCase;

  final GetStationDetailsWithRouteUseCase getStationDetailsWithRouteUseCase;

  final GetRouteBetweenStationUseCase getRouteBetweenStationUseCase;

  MapCubit({
    required this.getStationsUseCase,
    required this.getNearestStationUseCase,
    required this.getStationDetailsWithRouteUseCase,
    required this.getRouteBetweenStationUseCase,
  }) : super(const MapState());

  StreamSubscription<Position>? positionStream;
  final MapController mapController = MapController();

  Future<void> initialize() async {
    emit(state.copyWith(loading: true, errorMessage: null));

    await _getCurrentLocation();

    await getStations();

    emit(state.copyWith(loading: false));
  }

  void moveToStation(StationEntity station) {
  mapController.move(
    LatLng(station.lat, station.lng),
    14,
  );
}

  Future<void> _getCurrentLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      emit(state.copyWith(errorMessage: 'Location permission denied'));

      return;
    }

    final position = await Geolocator.getCurrentPosition();

    emit(state.copyWith(currentPosition: position));

    positionStream =
        Geolocator.getPositionStream(
          locationSettings: const LocationSettings(
            accuracy: LocationAccuracy.high,
            distanceFilter: 10,
          ),
        ).listen((position) async {
          emit(state.copyWith(currentPosition: position));

          if (state.selectedStation != null) {
            await getStationRoute(state.selectedStation!);
          }
        });
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

    emit(
      state.copyWith(
        routeLoading: true,
        selectedStation: station,
        errorMessage: null,
      ),
    );

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
        emit(state.copyWith(currentRoute: route, routeLoading: false));
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

  @override
  Future<void> close() {
    positionStream?.cancel();

    return super.close();
  }
}
