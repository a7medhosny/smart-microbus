class RouteEntity {
  final String id;
  final String from;
  final String to;
  final double price;
  final String stationId;

  const RouteEntity({
    required this.id,
    required this.from,
    required this.to,
    required this.price,
    required this.stationId,
  });

  String get fullName => "$from → $to";
}
