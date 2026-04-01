import 'driver_current_status.dart';

abstract class DashboardEvent {}

class DashboardUpdatedEvent extends DashboardEvent {
  final DriverCurrentStatus data;

  DashboardUpdatedEvent(this.data);
}