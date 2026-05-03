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
  final String searchQuery;
  final DriverLocationEntity? driverLocation;
  final MapMode mode;

  const MapState({
    this.searchQuery = '',
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
    this.driverLocation,
    this.mode = MapMode.station,
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
    String? searchQuery,
    DriverLocationEntity? driverLocation,
    MapMode? mode,
  }) {
    return MapState(
      loading: loading ?? this.loading,
      routeLoading: routeLoading ?? this.routeLoading,
      errorMessage: errorMessage,
      currentPosition: currentPosition ?? this.currentPosition,
      stations: stations ?? this.stations,
      selectedStation: selectedStation ?? this.selectedStation,
      currentRoute: currentRoute ?? this.currentRoute,
      routeBetweenStations: routeBetweenStations ?? this.routeBetweenStations,
      fromStation: fromStation ?? this.fromStation,
      toStation: toStation ?? this.toStation,
      selectedMode: selectedMode ?? this.selectedMode,
      searchQuery: searchQuery ?? this.searchQuery,
      driverLocation: driverLocation ?? this.driverLocation,
      mode: mode ?? this.mode,
    );
  }
}
