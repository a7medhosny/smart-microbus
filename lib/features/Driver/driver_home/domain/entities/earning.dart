class Earning {
  final DateTime date;
  final int totalTrips;
  final int totalPassengers;
  final double totalDistanceKm;
  final double totalEarnings;
  final String currency;
  final double averagePerTrip;
  final DateTime lastUpdated;

  const Earning({
    required this.date,
    required this.totalTrips,
    required this.totalPassengers,
    required this.totalDistanceKm,
    required this.totalEarnings,
    required this.currency,
    required this.averagePerTrip,
    required this.lastUpdated,
  });
}
