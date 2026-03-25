import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smart_microbus/features/Driver/driver_home/domain/entities/route.dart';

import '../../domain/entities/destination_entity.dart';
import '../../domain/entities/on_the_way_microbus_entity.dart';
import '../../domain/entities/report_entity.dart';
import '../../domain/entities/report_reason_entity.dart';
import '../../domain/entities/route_entity.dart';
import '../../domain/entities/route_summary_entity.dart';
import '../../domain/entities/station_microbus_entity.dart';
import '../../domain/entities/favourite_route_entity.dart';
import '../../domain/entities/report_entity.dart';
import '../../domain/entities/report_reason_entity.dart';

import '../../domain/usecases/get_report_reasons_use_case.dart';
import '../../domain/usecases/get_routes_use_case.dart';
import '../../domain/usecases/get_route_destination_use_case.dart';
import '../../domain/usecases/get_route_summary_use_case.dart';
import '../../domain/usecases/get_station_microbuses_use_case.dart';
import '../../domain/usecases/get_on_the_way_microbuses_use_case.dart';
import '../../domain/usecases/submit_report_use_case.dart';

import '../../domain/usecases/add_route_to_favourite_use_case.dart';
import '../../domain/usecases/is_route_favourite_use_case.dart';
import '../../domain/usecases/get_favourite_routes.dart';
import '../../domain/usecases/remove_route_from_fav_use_case.dart';
import '../../domain/usecases/submit_report_use_case.dart';
import '../../domain/usecases/get_report_reasons_use_case.dart';

part 'passenger_state.dart';

class PassengerCubit extends Cubit<PassengerState> {
  final GetRoutesUseCase getRoutesUseCase;
  final GetRouteDestinationUseCase getRouteDestinationUseCase;
  final GetRouteSummaryUseCase getRouteSummaryUseCase;
  final GetStationMicrobusesUseCase getStationMicrobusesUseCase;
  final GetOnTheWayMicrobusesUseCase getOnTheWayMicrobusesUseCase;
  final GetReportReasonsUseCase getReportReasonsUseCase;
  final SubmitReportUseCase submitReportUseCase;
  final AddRouteToFavouriteUseCase addRouteToFavouriteUseCase;
  final RemoveRouteFromFavUseCase removeRouteFromFavoritesUceCase;
  final IsRouteFavouriteUseCase isRouteFavouriteUseCase;
  final GetFavouriteRoutes getFavouriteRoutes;

  String? selectedRouteId;
  String? selectedCity;
  DestinationEntity? selectedDestination;
  List<DestinationEntity> destinations = [];
  List<PassengerRouteEntity> routes = [];

  // String plateNumber = "أ ب ج 1234"; // مؤقت (يتبعت من الشاشة بعدين)
  int? selectedReasonId;
  // String description = '';
  // bool get isOtherSelected => selectedReasonId == -1;
  List<FavouriteRouteEntity> favouriteRoutes = [];
  int currentNavIndex = 0;

  PassengerCubit(
    this.getRoutesUseCase,
    this.getRouteDestinationUseCase,
    this.getRouteSummaryUseCase,
    this.getStationMicrobusesUseCase,
    this.getOnTheWayMicrobusesUseCase,
    this.getReportReasonsUseCase,
    this.submitReportUseCase,
    this.addRouteToFavouriteUseCase,
    this.removeRouteFromFavoritesUceCase,
    this.isRouteFavouriteUseCase,
    this.getFavouriteRoutes,
  ) : super(PassengerInitial());

  void changeBottomNavIndex(int index) {
    currentNavIndex = index;
    emit(ChangePassengerBottomNavState(index));
  }

  // ================= ROUTES =================

  Future<void> getRoutes() async {
    emit(GetRoutesLoading());

    final result = await getRoutesUseCase();

    result.fold((failure) => emit(GetRoutesError(failure.message)), (data) {
      routes = data;
      emit(GetRoutesSuccess(data));
    });
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

  // ================= ALL DATA =================

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

  // =====================================================
  // ================= FAVORITES ==========================
  // =====================================================

  Future<void> addToFavorites(String routeId) async {
    emit(AddFavoriteLoading());

    final result = await addRouteToFavouriteUseCase(routeId);

    result.fold((failure) => emit(AddFavoriteError(failure.message)), (
      _,
    ) async {
      await getFavorites();
      emit(AddFavoriteSuccess());
    });
  }

  Future<void> removeFromFavorites(String routeId) async {
    emit(RemoveFavoriteLoading());

    final result = await removeRouteFromFavoritesUceCase(routeId);

    result.fold((failure) => emit(RemoveFavoriteError(failure.message)), (
      _,
    ) async {
      await getFavorites();
      emit(RemoveFavoriteSuccess());
    });
  }

  Future<void> checkIfFavorite(String routeId) async {
    emit(CheckFavoriteLoading());
    if (favouriteRoutes.any((route) => route.routeId == routeId)) {
      emit(CheckFavoriteSuccess(true));
      return;
    } else {
      emit(CheckFavoriteSuccess(false));
      return;
    }
    final result = await isRouteFavouriteUseCase(routeId);

    result.fold(
      (failure) => emit(CheckFavoriteError(failure.message)),
      (isFav) => emit(CheckFavoriteSuccess(isFav)),
    );
  }

  Future<void> getFavorites() async {
    emit(GetFavoritesLoading());

    final result = await getFavouriteRoutes();

    result.fold((failure) => emit(GetFavoritesError(failure.message)), (data) {
      favouriteRoutes = data;
      emit(GetFavoritesSuccess(data));
    });
  }

  // =====================================================
  // ================= REPORT =============================
  // =====================================================

  Future<void> submitReport(ReportEntity report) async {
    emit(SubmitReportLoading());

    final result = await submitReportUseCase(report);

    result.fold(
      (failure) => emit(SubmitReportError(failure.message)),
      (data) => emit(SubmitReportSuccess(data.message)),
    );
  }

  Future<void> getReportReasons() async {
    emit(GetReportReasonsLoading());

    final result = await getReportReasonsUseCase();

    result.fold(
      (failure) => emit(GetReportReasonsError(failure.message)),
      (reasons) => emit(GetReportReasonsSuccess(reasons, null)),
    );
  }

  // // ================= SUBMIT REPORT =================

  // Future<void> submitReport({required ReportEntity report}) async {
  //   emit(SubmitReportLoading());

  //   final result = await submitReportUseCase(report);

  //   result.fold(
  //     (failure) => emit(SubmitReportError(failure.message)),
  //     (reasons) => emit(SubmitReportSuccess(reasons.message)),
  //     (data) => emit(GetReportReasonsSuccess(data)),
  //   );
  // }
}
