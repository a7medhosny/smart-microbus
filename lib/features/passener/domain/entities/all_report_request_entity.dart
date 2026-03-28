class AllrportRequestEntity {
  final String? plateNumber;
  final DateTime? fromDate;
  final DateTime? toDate;
  final int? pageNumber;
  final int? pageSize;

  AllrportRequestEntity({
    this.plateNumber,
    this.fromDate,
    this.toDate,
    this.pageNumber,
    this.pageSize,
  });
}
