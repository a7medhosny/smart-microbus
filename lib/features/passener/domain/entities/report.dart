class Report {
  final List<String> reasons;
  final String description;
  final String id;
  final String plateNumber;
  final String createdAt;
  final String status;

  Report({
    required this.reasons,
    required this.description,
    required this.id,
    required this.plateNumber,
    required this.createdAt,
    required this.status,
  });
}
