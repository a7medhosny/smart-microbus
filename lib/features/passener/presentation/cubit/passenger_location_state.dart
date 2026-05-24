part of 'passenger_location_cubit.dart';

class PassengerLocationState extends Equatable {
  final bool loading;

  final DriverLocationEntity? location;

  final String? error;

  final int guestTrigger;

  const PassengerLocationState({
    this.loading = false,
    this.location,
    this.error,
    this.guestTrigger = 0,
  });

  PassengerLocationState copyWith({
    bool? loading,
    DriverLocationEntity? location,
    String? error,

    int? guestTrigger,
  }) {
    return PassengerLocationState(
      loading: loading ?? this.loading,
      location: location ?? this.location,
      error: error,
      guestTrigger: guestTrigger ?? this.guestTrigger,
    );
  }

  @override
  List<Object?> get props => [loading, location, error, guestTrigger];
}
