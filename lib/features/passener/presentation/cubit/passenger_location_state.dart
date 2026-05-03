part of 'passenger_location_cubit.dart';

class PassengerLocationState extends Equatable {
  final bool loading;

  final DriverLocationEntity? location;

  final String? error;

  const PassengerLocationState({
    this.loading = false,
    this.location,
    this.error,
  });

  PassengerLocationState copyWith({
    bool? loading,
    DriverLocationEntity? location,
    String? error,
  }) {
    return PassengerLocationState(
      loading: loading ?? this.loading,
      location: location ?? this.location,
      error: error,
    );
  }

  @override
  List<Object?> get props => [
        loading,
        location,
        error,
      ];
}