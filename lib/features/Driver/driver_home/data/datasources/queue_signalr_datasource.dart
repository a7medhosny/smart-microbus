import '../../domain/entities/dashboard_event.dart';
import '../../domain/entities/queue_event.dart';

abstract class QueueSignalRDataSource {
  Future<void> connectQueue(String queueId);
  Future<void> connectDashboard();

  Future<void> disconnectQueue();
  Future<void> disconnectDashboard();
  Future<void> disconnectAll();

  Stream<QueueEvent> get queueEvents;
  Stream<DashboardEvent> get dashboardEvents;
}