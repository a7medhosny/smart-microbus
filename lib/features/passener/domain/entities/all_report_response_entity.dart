import 'report_item_entity.dart';

class AllReportResponseEntity {
  final List<ReportItemEntity> items;
  final int totalCount;
  final int pageNumber;
  final int pageSize;

  AllReportResponseEntity({
    required this.items,
    required this.totalCount,
    required this.pageNumber,
    required this.pageSize,
  });
}
