class ReportEntity {
  final String plateNumber;
  final List<int> reasonIds;
  final String? description;

  ReportEntity({
    required this.plateNumber,
    required this.reasonIds,
    required this.description,
  });
}
