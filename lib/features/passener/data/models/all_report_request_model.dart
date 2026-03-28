import 'package:smart_microbus/features/passener/domain/entities/all_report_request_entity.dart';

class AllReportRequestModel {
  final String? plateNumber;
  final DateTime? fromDate;
  final DateTime? toDate;
  final int? pageNumber;
  final int? pageSize;

  AllReportRequestModel({
    this.plateNumber,
    this.fromDate,
    this.toDate,
    this.pageNumber,
    this.pageSize,
  });

  Map<String, dynamic> toQuery() {
    final map = <String, dynamic>{};

    if (plateNumber != null && plateNumber!.isNotEmpty) {
      map["PlateNumber"] = plateNumber;
    }

    if (fromDate != null) {
      map["FromDate"] = fromDate!.toIso8601String();
    }

    if (toDate != null) {
      map["ToDate"] = toDate!.toIso8601String();
    }

    if (pageNumber != null) {
      map["PageNumber"] = pageNumber;
    }

    if (pageSize != null) {
      map["PageSize"] = pageSize;
    }

    return map;
  }
}

extension AllReportRequestMapper on AllReportRequestModel {
  AllrportRequestEntity toEntity() {
    return AllrportRequestEntity(
      plateNumber: plateNumber,
      fromDate: fromDate,
      toDate: toDate,
      pageNumber: pageNumber,
      pageSize: pageSize,
    );
  }
}
