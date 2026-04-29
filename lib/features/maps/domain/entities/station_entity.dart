class StationEntity {
  final String id;
  final String name;
  final String city;
  final String? address;
  final double lat;
  final double lng;

  StationEntity({
    required this.id,
    required this.name,
    required this.city,
    this.address,
    required this.lat,
    required this.lng,
  });
}
