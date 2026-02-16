import 'queue_item.dart';

class QueueResponse {
  final String id;
  final String stationId;
  final String routeId;
  final List<QueueItem> items;

  const QueueResponse({
    required this.id,
    required this.stationId,
    required this.routeId,
    required this.items,
  });

  int get length => items.length;
}
