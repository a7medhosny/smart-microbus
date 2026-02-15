import 'queue_item.dart';

class Queue {
  final String id;
  final String stationId;
  final String routeId;
  final List<QueueItem> items;

  const Queue({
    required this.id,
    required this.stationId,
    required this.routeId,
    required this.items,
  });

  int get length => items.length;
}
