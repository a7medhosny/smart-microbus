part of 'passenger_cubit.dart';

sealed class PassengerState extends Equatable {
  const PassengerState();

  @override
  List<Object?> get props => [];
}

// ================= INITIAL =================

final class PassengerInitial extends PassengerState {}

// =====================================================
// ===================== ROUTES =========================
// =====================================================

final class GetRoutesLoading extends PassengerState {}

final class GetRoutesSuccess extends PassengerState {
  final List<PassengerRouteEntity> routes;

  const GetRoutesSuccess(this.routes);

  @override
  List<Object?> get props => [routes];
}

final class GetRoutesError extends PassengerState {
  final String message;

  const GetRoutesError(this.message);

  @override
  List<Object?> get props => [message];
}

// =====================================================
// ================= DESTINATIONS =======================
// =====================================================

final class GetDestinationsLoading extends PassengerState {}

final class GetDestinationsSuccess extends PassengerState {
  final List<DestinationEntity> destinations;

  const GetDestinationsSuccess(this.destinations);

  @override
  List<Object?> get props => [destinations];
}

final class GetDestinationsError extends PassengerState {
  final String message;

  const GetDestinationsError(this.message);

  @override
  List<Object?> get props => [message];
}

// =====================================================
// ================= ROUTE SUMMARY ======================
// =====================================================

final class GetRouteSummaryLoading extends PassengerState {}

final class GetRouteSummarySuccess extends PassengerState {
  final RouteSummaryEntity summary;

  const GetRouteSummarySuccess(this.summary);

  @override
  List<Object?> get props => [summary];
}

final class GetRouteSummaryError extends PassengerState {
  final String message;

  const GetRouteSummaryError(this.message);

  @override
  List<Object?> get props => [message];
}

// =====================================================
// ============== STATION MICROBuses ====================
// =====================================================

final class GetStationMicrobusesLoading extends PassengerState {}

final class GetStationMicrobusesSuccess extends PassengerState {
  final List<StationMicrobusEntity> microbuses;

  const GetStationMicrobusesSuccess(this.microbuses);

  @override
  List<Object?> get props => [microbuses];
}

final class GetStationMicrobusesError extends PassengerState {
  final String message;

  const GetStationMicrobusesError(this.message);

  @override
  List<Object?> get props => [message];
}

// =====================================================
// ============ ON THE WAY MICROBuses ===================
// =====================================================

final class GetOnTheWayMicrobusesLoading extends PassengerState {}

final class GetOnTheWayMicrobusesSuccess extends PassengerState {
  final List<OnTheWayMicrobusEntity> microbuses;

  const GetOnTheWayMicrobusesSuccess(this.microbuses);

  @override
  List<Object?> get props => [microbuses];
}

final class GetOnTheWayMicrobusesError extends PassengerState {
  final String message;

  const GetOnTheWayMicrobusesError(this.message);

  @override
  List<Object?> get props => [message];
}

class PassengerDataState extends PassengerState {
  final RouteSummaryEntity? summary;
  final List<StationMicrobusEntity>? station;
  final List<OnTheWayMicrobusEntity>? onTheWay;
  final bool isLoading;

  const PassengerDataState({
    this.summary,
    this.station,
    this.onTheWay,
    this.isLoading = false,
  });

  @override
  List<Object?> get props => [summary, station, onTheWay, isLoading];
}

final class PassengerDataError extends PassengerState {
  final String message;

  const PassengerDataError(this.message);

  @override
  List<Object?> get props => [message];
}
// ================= REPORT =================

final class GetReportReasonsLoading extends PassengerState {}

final class GetReportReasonsSuccess extends PassengerState {
  final List<ReportReasonEntity> reasons;
  final int? selectedReasonId;
  final String description;

  const GetReportReasonsSuccess(
    this.reasons,
    this.selectedReasonId, {
    this.description = '',
  });

  @override
  List<Object?> get props => [reasons, selectedReasonId, description];
}

final class GetReportReasonsError extends PassengerState {
  final String message;

  const GetReportReasonsError(this.message);

  @override
  List<Object?> get props => [message];
}

// ---------------- SUBMIT ----------------

final class SubmitReportLoading extends PassengerState {}

final class SubmitReportSuccess extends PassengerState {
  final String message;

  const SubmitReportSuccess(this.message);
}

final class SubmitReportError extends PassengerState {
  final String message;

  const SubmitReportError(this.message);

  @override
  List<Object?> get props => [message];
}
