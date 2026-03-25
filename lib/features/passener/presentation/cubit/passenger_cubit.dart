import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/destination_entity.dart';
import '../../domain/entities/on_the_way_microbus_entity.dart';
import '../../domain/entities/report_entity.dart';
import '../../domain/entities/report_reason_entity.dart';
import '../../domain/entities/route_entity.dart';
import '../../domain/entities/route_summary_entity.dart';
import '../../domain/entities/station_microbus_entity.dart';

import '../../domain/usecases/get_report_reasons_use_case.dart';
import '../../domain/usecases/get_routes_use_case.dart';
import '../../domain/usecases/get_route_destination_use_case.dart';
import '../../domain/usecases/get_route_summary_use_case.dart';
import '../../domain/usecases/get_station_microbuses_use_case.dart';
import '../../domain/usecases/get_on_the_way_microbuses_use_case.dart';
import '../../domain/usecases/submit_report_use_case.dart';

part 'passenger_state.dart';

class PassengerCubit extends Cubit<PassengerState> {
  final GetRoutesUseCase getRoutesUseCase;
  final GetRouteDestinationUseCase getRouteDestinationUseCase;
  final GetRouteSummaryUseCase getRouteSummaryUseCase;
  final GetStationMicrobusesUseCase getStationMicrobusesUseCase;
  final GetOnTheWayMicrobusesUseCase getOnTheWayMicrobusesUseCase;
  final GetReportReasonsUseCase getReportReasonsUseCase;
  final SubmitReportUseCase submitReportUseCase;
  String? selectedRouteId;
  String? selectedCity;
  DestinationEntity? selectedDestination;
  List<DestinationEntity> destinations = [];
  String plateNumber = "أ ب ج 1234"; // مؤقت (يتبعت من الشاشة بعدين)
  int? selectedReasonId;
  String description = '';
  bool get isOtherSelected => selectedReasonId == -1;
  PassengerCubit(
    this.getRoutesUseCase,
    this.getRouteDestinationUseCase,
    this.getRouteSummaryUseCase,
    this.getStationMicrobusesUseCase,
    this.getOnTheWayMicrobusesUseCase,
    this.getReportReasonsUseCase,
    this.submitReportUseCase,
  ) : super(PassengerInitial());

  // ================= ROUTES =================

  Future<void> getRoutes() async {
    emit(GetRoutesLoading());

    final result = await getRoutesUseCase();

    result.fold(
      (failure) => emit(GetRoutesError(failure.message)),
      (data) => emit(GetRoutesSuccess(data)),
    );
  }

  // ================= DESTINATIONS =================

  Future<void> getRouteDestination(String from) async {
    emit(GetDestinationsLoading());

    final result = await getRouteDestinationUseCase(from);

    result.fold(
      (failure) => emit(GetDestinationsError(failure.message)),
      (data) => emit(GetDestinationsSuccess(data)),
    );
  }

  Future<void> getAllRouteData(String routeId) async {
    emit(const PassengerDataState(isLoading: true));

    final results = await Future.wait([
      getRouteSummaryUseCase(routeId),
      getStationMicrobusesUseCase(routeId),
      getOnTheWayMicrobusesUseCase(routeId),
    ]);

    final summaryResult = results[0] as dynamic;
    final stationResult = results[1] as dynamic;
    final onTheWayResult = results[2] as dynamic;

    RouteSummaryEntity? summary;
    List<StationMicrobusEntity>? station;
    List<OnTheWayMicrobusEntity>? onTheWay;

    String? error;

    summaryResult.fold(
      (failure) => error ??= failure.message,
      (data) => summary = data,
    );

    stationResult.fold(
      (failure) => error ??= failure.message,
      (data) => station = data,
    );

    onTheWayResult.fold(
      (failure) => error ??= failure.message,
      (data) => onTheWay = data,
    );

    /// لو في error
    if (error != null) {
      emit(PassengerDataError(error!));
      return;
    }

    emit(
      PassengerDataState(
        summary: summary,
        station: station,
        onTheWay: onTheWay,
        isLoading: false,
      ),
    );
  }
  // ================= REPORT =================

  Future<void> getReportReasons() async {
    emit(GetReportReasonsLoading());

    final result = await getReportReasonsUseCase();

    result.fold(
      (failure) => emit(GetReportReasonsError(failure.message)),
      (reasons) => emit(GetReportReasonsSuccess(reasons, null)),
    );
  }

  // ================= SUBMIT REPORT =================

  Future<void> submitReport({required ReportEntity report}) async {
    emit(SubmitReportLoading());

    final result = await submitReportUseCase(report);

    result.fold(
      (failure) => emit(SubmitReportError(failure.message)),
      (reasons) => emit(SubmitReportSuccess(reasons.message)),
    );
  }
}
