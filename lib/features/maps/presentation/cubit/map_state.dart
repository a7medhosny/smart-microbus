part of 'map_cubit.dart';

class MapState {
  final bool loading;
  final bool routeLoading;

  final String? errorMessage;

  final Position? currentPosition;

  final List<StationEntity> stations;

  final StationEntity? selectedStation;

  final RouteInfoEntity? currentRoute;

  final RouteInfoEntity? routeBetweenStations;

  final StationEntity? fromStation;

  final StationEntity? toStation;

  final TravelMode selectedMode;

  const MapState({
    this.loading = false,
    this.routeLoading = false,
    this.errorMessage,
    this.currentPosition,
    this.stations = const [],
    this.selectedStation,
    this.currentRoute,
    this.routeBetweenStations,
    this.fromStation,
    this.toStation,
    this.selectedMode = TravelMode.driving,
  });

  MapState copyWith({
    bool? loading,
    bool? routeLoading,
    String? errorMessage,
    Position? currentPosition,
    List<StationEntity>? stations,
    StationEntity? selectedStation,
    RouteInfoEntity? currentRoute,
    RouteInfoEntity? routeBetweenStations,
    StationEntity? fromStation,
    StationEntity? toStation,
    TravelMode? selectedMode,
  }) {
    return MapState(
      loading: loading ?? this.loading,
      routeLoading: routeLoading ?? this.routeLoading,
      errorMessage: errorMessage,
      currentPosition: currentPosition ?? this.currentPosition,
      stations: stations ?? this.stations,
      selectedStation: selectedStation ?? this.selectedStation,
      currentRoute: currentRoute ?? this.currentRoute,
      routeBetweenStations:
          routeBetweenStations ?? this.routeBetweenStations,
      fromStation: fromStation ?? this.fromStation,
      toStation: toStation ?? this.toStation,
      selectedMode: selectedMode ?? this.selectedMode,
    );
  }
}