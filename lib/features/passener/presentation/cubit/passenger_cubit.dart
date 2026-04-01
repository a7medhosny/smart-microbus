import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_microbus/features/passener/domain/entities/report_item_entity.dart';

import '../../../../core/storage/cache_helper.dart';
import '../../../../core/storage/cache_keys.dart';
import '../../domain/entities/all_report_request_entity.dart';
import '../../domain/entities/all_report_response_entity.dart';
import '../../domain/entities/destination_entity.dart';
import '../../domain/entities/favourite_route_entity.dart';
import '../../domain/entities/on_the_way_microbus_entity.dart';
import '../../domain/entities/report.dart';
import '../../domain/entities/report_entity.dart';
import '../../domain/entities/report_reason_entity.dart';
import '../../domain/entities/route_entity.dart';
import '../../domain/entities/route_summary_entity.dart';
import '../../domain/entities/station_microbus_entity.dart';

import '../../domain/usecases/add_route_to_favourite_use_case.dart';
import '../../domain/usecases/delete_report_by_id_use_case.dart';
import '../../domain/usecases/get_all_reports_use_case.dart';
import '../../domain/usecases/get_driver_by_plate_number.dart';
import '../../domain/usecases/get_favourite_routes.dart';
import '../../domain/usecases/get_on_the_way_microbuses_use_case.dart';
import '../../domain/usecases/get_report_by_id_use_case.dart';
import '../../domain/usecases/get_report_reasons_use_case.dart';
import '../../domain/usecases/get_route_destination_use_case.dart';
import '../../domain/usecases/get_route_summary_use_case.dart';
import '../../domain/usecases/get_routes_use_case.dart';
import '../../domain/usecases/get_station_microbuses_use_case.dart';
import '../../domain/usecases/is_route_favourite_use_case.dart';
import '../../domain/usecases/remove_route_from_fav_use_case.dart';
import '../../domain/usecases/submit_report_use_case.dart';
import '../../domain/usecases/update_report_use_case.dart';

part 'passenger_state.dart';

class PassengerCubit extends Cubit<PassengerState> {
  // ================= USE CASES =================
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
  final GetAllReportsUseCase getAllReportsUseCase;
  final GetReportByIdUseCase getReportByIdUseCase;
  final DeleteReportByIdUseCase deleteReportByIdUseCase;
  final UpdateReportUseCase updateReportUseCase;
  final GetDriverByPlateNumber getDriverByPlateNumber;

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
    this.getAllReportsUseCase,
    this.getReportByIdUseCase,
    this.deleteReportByIdUseCase,
    this.updateReportUseCase,
    this.getDriverByPlateNumber,
  ) : super(PassengerInitial());

  // ================= STATE DATA =================
  String? selectedRouteId;
  String? selectedCity;
  DestinationEntity? selectedDestination;

  List<DestinationEntity> destinations = [];
  List<PassengerRouteEntity> routes = [];
  List<FavouriteRouteEntity> favouriteRoutes = [];
  // List<ReportItemEntity> reportItems = [];

  int? selectedReasonId;

  // ================= NAVIGATION =================
  int currentNavIndex = 0;
  String? lang = CacheHelper.getCacheData(key: CacheKeys.localeKey);

  final List<GlobalKey<NavigatorState>> navigatorKeys = List.generate(
    4,
    (_) => GlobalKey<NavigatorState>(),
  );

  GlobalKey<NavigatorState> get currentNavigatorKey =>
      navigatorKeys[currentNavIndex];

  bool showSearchField = false;
  final TextEditingController searchPlateController = TextEditingController();

  void changeBottomNavIndex(int index) {
    currentNavIndex = index;
    if (lang != CacheHelper.getCacheData(key: CacheKeys.localeKey)) {
      lang = CacheHelper.getCacheData(key: CacheKeys.localeKey);
      getRoutes();
      getFavorites();
      getAllReports();
    }
    // print('lang : ${lang}');
    // print(
    //   'System lang : ${CacheHelper.getCacheData(key: CacheKeys.localeKey)}',
    // );

    emit(ChangePassengerBottomNavState(index));
  }

  void resetRouteSelection() {
    selectedCity = null;
    selectedRouteId = null;
    selectedDestination = null;
    destinations.clear();

    emit(PassengerInitial());
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

  // ================= FAVORITES =================
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

    final isFav = favouriteRoutes.any((route) => route.routeId == routeId);

    emit(CheckFavoriteSuccess(isFav));

    //  final result = await isRouteFavouriteUseCase(routeId);

    // result.fold(
    //   (failure) => emit(CheckFavoriteError(failure.message)),
    //   (isFav) => emit(CheckFavoriteSuccess(isFav)),
    // );
  }

  Future<void> getFavorites() async {
    emit(GetFavoritesLoading());

    final result = await getFavouriteRoutes();

    result.fold((failure) => emit(GetFavoritesError(failure.message)), (data) {
      favouriteRoutes = data;
      print("🔥 FAVORITE LOADED: ${data.length}");
      emit(GetFavoritesSuccess(data));
    });
  }

  // ================= REPORT =================
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

  AllReportResponseEntity? allReports;
  Report? currentReport;

  /// ================= GET ALL REPORTS =================
  Future<void> getAllReports({AllrportRequestEntity? filters}) async {
    if (filters == null && allReports != null) {
      emit(GetAllReportsSuccess(allReports!));
      return;
    }

    emit(GetAllReportsLoading());

    final result = await getAllReportsUseCase(requestEntity: filters);

    result.fold((failure) => emit(GetAllReportsError(failure.message)), (data) {
      allReports = data;
      print("🔥 All Reports Loaded: ${data.items.length}");
      emit(GetAllReportsSuccess(data));
    });
  }

  /// ================= GET REPORT BY ID =================
  Future<void> getReportById(String id) async {
    emit(GetReportByIdLoading());

    final result = await getReportByIdUseCase(id);

    result.fold((failure) => emit(GetReportByIdError(failure.message)), (data) {
      currentReport = data;
      emit(GetReportByIdSuccess(data));
    });
  }

  /// ================= DELETE =================
  Future<void> deleteReport(String id) async {
    emit(DeleteReportLoading());

    final result = await deleteReportByIdUseCase(id);

    result.fold((failure) => emit(DeleteReportError(failure.message)), (
      data,
    ) async {
      allReports?.items.removeWhere((report) => report.id == id);
      getAllReports();
      emit(DeleteReportSuccess(data.message));
    });
  }

  /// ================= UPDATE =================
  Future<void> updateReport(String id, ReportEntity report) async {
    emit(UpdateReportLoading());

    final result = await updateReportUseCase(id, report);

    result.fold((failure) => emit(UpdateReportError(failure.message)), (
      data,
    ) async {
      await getReportById(id);
      emit(UpdateReportSuccess(data.message));
    });
  }

  StationMicrobusEntity? driverByPlate;

  Future<void> getDriverByPlate(String plateNumber) async {
    emit(GetDriverByPlateNumberLoading());

    final result = await getDriverByPlateNumber(plateNumber);

    result.fold(
      (failure) => emit(GetDriverByPlateNumberError(failure.message)),
      (driver) {
        driverByPlate = driver;
        emit(GetDriverByPlateNumberSuccess(driver));
      },
    );
  }
}
