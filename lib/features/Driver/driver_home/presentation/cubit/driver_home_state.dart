part of 'driver_home_cubit.dart';

sealed class DriverHomeState extends Equatable {
  const DriverHomeState();

  @override
  List<Object?> get props => [];
}

// ================= INITIAL =================

final class DriverHomeInitial extends DriverHomeState {}


// =====================================================
// =============== CURRENT POSITION =====================
// =====================================================

final class GetCurrentPositionLoading extends DriverHomeState {}

final class GetCurrentPositionSuccess extends DriverHomeState {
  final QueueItem position;

  const GetCurrentPositionSuccess(this.position);

  @override
  List<Object?> get props => [position];
}

final class GetCurrentPositionError extends DriverHomeState {
  final String message;

  const GetCurrentPositionError(this.message);

  @override
  List<Object?> get props => [message];
}


// =====================================================
// =============== DAILY EARNINGS =======================
// =====================================================

final class GetDailyEarningsLoading extends DriverHomeState {}

final class GetDailyEarningsSuccess extends DriverHomeState {
  final Earning earning;

  const GetDailyEarningsSuccess(this.earning);

  @override
  List<Object?> get props => [earning];
}

final class GetDailyEarningsError extends DriverHomeState {
  final String message;

  const GetDailyEarningsError(this.message);

  @override
  List<Object?> get props => [message];
}


// =====================================================
// ================= STATION QUEUE ======================
// =====================================================

final class GetStationQueueLoading extends DriverHomeState {}

final class GetStationQueueSuccess extends DriverHomeState {
  final QueueResponse queue;

  const GetStationQueueSuccess(this.queue);

  @override
  List<Object?> get props => [queue];
}

final class GetStationQueueError extends DriverHomeState {
  final String message;

  const GetStationQueueError(this.message);

  @override
  List<Object?> get props => [message];
}


// =====================================================
// ================= TRIP HISTORY =======================
// =====================================================

final class GetTripHistoryLoading extends DriverHomeState {}

final class GetTripHistorySuccess extends DriverHomeState {
  final TripHistoryResponse trips;

  const GetTripHistorySuccess(this.trips);

  @override
  List<Object?> get props => [trips];
}

final class GetTripHistoryError extends DriverHomeState {
  final String message;

  const GetTripHistoryError(this.message);

  @override
  List<Object?> get props => [message];
}


// =====================================================
// ============ QUEUE NOTIFICATIONS =====================
// =====================================================

final class ListenQueueNotificationsLoading extends DriverHomeState {}

final class ListenQueueNotificationsSuccess extends DriverHomeState {
  final QueueEvent event;

  const ListenQueueNotificationsSuccess(this.event);

  @override
  List<Object?> get props => [event];
}

final class ListenQueueNotificationsError extends DriverHomeState {
  final String message;

  const ListenQueueNotificationsError(this.message);

  @override
  List<Object?> get props => [message];
}
