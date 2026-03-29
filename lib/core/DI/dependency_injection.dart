import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:smart_microbus/core/networking/dio_factory.dart';
import 'package:smart_microbus/features/Driver/driver_home/data/datasources/queue_signalr_datasource.dart';
import 'package:smart_microbus/features/Driver/driver_home/data/repository/driver_home_repository_impl.dart';
import 'package:smart_microbus/features/Driver/driver_home/domain/usecases/connect_queue.dart';
import 'package:smart_microbus/features/Driver/driver_home/domain/usecases/end_trip_use_case.dart';
import 'package:smart_microbus/features/Driver/driver_home/domain/usecases/get_current_position_use_case.dart';
import 'package:smart_microbus/features/Driver/driver_home/domain/usecases/get_estimated_daily_earnings_use_case.dart';
import 'package:smart_microbus/features/Driver/driver_home/domain/usecases/get_station_queue_use_case.dart';
import 'package:smart_microbus/features/Driver/driver_home/domain/usecases/get_trip_history_use_case.dart';
import 'package:smart_microbus/features/Driver/driver_home/domain/usecases/listen_to_queue_notifications_use_case.dart';
import 'package:smart_microbus/features/Driver/driver_home/domain/usecases/start_trip_use_case.dart';
import 'package:smart_microbus/features/Driver/driver_home/presentation/cubit/driver_home_cubit.dart';
import 'package:smart_microbus/features/passener/data/datasource/passenger_api_service.dart';
import 'package:smart_microbus/features/passener/data/datasource/passenger_remote_data_source.dart';
import 'package:smart_microbus/features/passener/domain/repos/passenger_repo.dart';
import 'package:smart_microbus/features/passener/domain/usecases/delete_report_by_id_use_case.dart';
import 'package:smart_microbus/features/passener/domain/usecases/get_all_reports_use_case.dart';
import 'package:smart_microbus/features/passener/domain/usecases/get_report_by_id_use_case.dart';
import 'package:smart_microbus/features/passener/domain/usecases/update_report_use_case.dart';
import 'package:smart_microbus/features/passener/presentation/cubit/passenger_cubit.dart';
import 'package:smart_microbus/features/profile/domain/usecases/logout_use_case.dart';
import 'package:smart_microbus/features/register/data/datasource/register_api_service.dart';
import 'package:smart_microbus/features/register/data/datasource/register_remote_data_source.dart';
import 'package:smart_microbus/features/register/data/datasource/register_remote_data_source_impl.dart';
import 'package:smart_microbus/features/register/domain/repositories/register_repository.dart';
import 'package:smart_microbus/features/register/domain/usecases/confirm_account_use_case.dart';
import 'package:smart_microbus/features/register/domain/usecases/resend_confirmation_use_case.dart';
import 'package:smart_microbus/features/Auth/login/data/datasource/login_api_service.dart';
import 'package:smart_microbus/features/Auth/login/data/datasource/login_remote_data_source.dart';
import 'package:smart_microbus/features/Auth/login/data/datasource/login_remote_data_source_impl.dart';
import 'package:smart_microbus/features/Auth/login/data/repos/login_repo._impl.dart';
import 'package:smart_microbus/features/Auth/login/domain/repos/login_repo.dart';
import 'package:smart_microbus/features/Auth/login/domain/usecases/forget_password_use_case.dart';
import 'package:smart_microbus/features/Auth/login/domain/usecases/login_use_case.dart';
import 'package:smart_microbus/features/Auth/login/domain/usecases/reset_password_use_case.dart';
import 'package:smart_microbus/features/Auth/login/presentation/cubit/cubit/login_cubit.dart';

import '../../features/Driver/driver_home/data/datasources/driver_home_api_service.dart';
import '../../features/Driver/driver_home/data/datasources/driver_home_data_source.dart';
import '../../features/Driver/driver_home/data/datasources/driver_home_data_source_impl.dart'
    show DriverHomeDataSourceImpl;
import '../../features/Driver/driver_home/data/datasources/queue_signalr_datasource_impl.dart';
import '../../features/Driver/driver_home/domain/repository/driver_home_repository.dart'
    show DriverHomeRepository;
import '../../features/passener/data/datasource/passenger_remote_data_source_impl.dart';
import '../../features/passener/data/repos/passenger_repo_impl.dart';
import '../../features/passener/domain/usecases/add_route_to_favourite_use_case.dart';
import '../../features/passener/domain/usecases/get_favourite_routes.dart';
import '../../features/passener/domain/usecases/get_on_the_way_microbuses_use_case.dart';
import '../../features/passener/domain/usecases/get_report_reasons_use_case.dart';
import '../../features/passener/domain/usecases/get_route_destination_use_case.dart';
import '../../features/passener/domain/usecases/get_route_summary_use_case.dart';
import '../../features/passener/domain/usecases/get_routes_use_case.dart';
import '../../features/passener/domain/usecases/get_station_microbuses_use_case.dart';
import '../../features/passener/domain/usecases/is_route_favourite_use_case.dart';
import '../../features/passener/domain/usecases/remove_route_from_fav_use_case.dart';
import '../../features/passener/domain/usecases/submit_report_use_case.dart';
import '../../features/profile/data/datasource/profile_api_service.dart';
import '../../features/profile/data/datasource/profile_remote_data_source.dart';
import '../../features/profile/data/datasource/profile_remote_data_source_impl.dart';
import '../../features/profile/data/repositories/profile_repository_impl.dart';
import '../../features/profile/domain/repositories/profile_repository.dart';
import '../../features/profile/domain/usecases/delete_account_use_case.dart';
import '../../features/profile/domain/usecases/delete_profile_photo_use_case.dart';
import '../../features/profile/domain/usecases/get_profile_usecase.dart';
import '../../features/profile/domain/usecases/change_password_usecase.dart';
import '../../features/profile/domain/usecases/upload_profile_photo_use_case.dart';
import '../../features/profile/presentation/cubit/profile_cubit.dart';
import '../../features/register/data/repositoies/register_repository_impl.dart';
import '../../features/register/domain/usecases/register_driver_use_case.dart';
import '../../features/register/domain/usecases/register_passenger_use_case.dart';
import '../../features/register/domain/usecases/verify_otp_use_case.dart';
import '../../features/register/presentation/cubit/register_cubit.dart';
import '../storage/cache_helper.dart';

import '../localization/locale_cubit.dart';
import '../localization/locale_storage.dart';

import '../theme/theme_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupDependencyInjection() async {
  getIt.registerLazySingleton<Dio>(() => DioFactory.getDio());
  // =========================
  // External
  // =========================

  await CacheHelper.cacheInitialization();

  // =========================
  // Storage / Services
  // =========================

  getIt.registerLazySingleton<LocaleStorage>(() => LocaleStorage());

  // =========================
  // Cubits
  // =========================

  getIt.registerFactory<LocaleCubit>(
    () => LocaleCubit(getIt<LocaleStorage>())..loadSavedLocale(),
  );

  // getIt.registerLazySingleton<Dio>(() => DioFactory.getDio());

  getIt.registerFactory<ThemeCubit>(() => ThemeCubit());

  _registerDependencies();

  _driverDependencies();

  /// API
  getIt.registerLazySingleton<ProfileApiService>(
    () => ProfileApiService(getIt()),
  );

  /// DataSource
  getIt.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImpl(getIt()),
  );

  /// Repository
  getIt.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(getIt(), getIt()),
  );

  /// UseCases
  getIt.registerLazySingleton(() => GetProfileUseCase(getIt()));
  getIt.registerLazySingleton(() => ChangePasswordUseCase(getIt()));
  getIt.registerLazySingleton(() => LogoutUseCase(getIt()));
  getIt.registerLazySingleton(() => DeleteAccountUseCase(getIt()));
  getIt.registerLazySingleton(() => UploadProfilePhotoUseCase(getIt()));
  getIt.registerLazySingleton(() => DeleteProfilePhotoUseCase(getIt()));

  /// Cubit
  getIt.registerFactory(
    () => ProfileCubit(
      getIt(),
      getIt(),
      getIt(),
      deleteAccountUseCase: getIt(),
      uploadProfilePhotoUseCase: getIt(),
      deleteProfilePhotoUseCase: getIt(),
    ),
  );
}

void _registerDependencies() {
  // ================= API =================

  getIt.registerLazySingleton<RegisterApiService>(
    () => RegisterApiService(getIt()),
  );

  // ================= DATA SOURCE =================

  getIt.registerLazySingleton<RegisterRemoteDataSource>(
    () => RegisterRemoteDataSourceImpl(getIt<RegisterApiService>()),
  );

  // ================= REPOSITORY =================

  getIt.registerLazySingleton<RegisterRepository>(
    () => RegisterRepositoryImpl(getIt<RegisterRemoteDataSource>()),
  );

  // ================= USE CASES =================

  getIt.registerLazySingleton<RegisterPassengerUseCase>(
    () => RegisterPassengerUseCase(getIt<RegisterRepository>()),
  );

  getIt.registerLazySingleton<RegisterDriverUseCase>(
    () => RegisterDriverUseCase(getIt<RegisterRepository>()),
  );

  getIt.registerLazySingleton<VerifyOtpUseCase>(
    () => VerifyOtpUseCase(getIt<RegisterRepository>()),
  );
  getIt.registerLazySingleton<ConfirmAccountUseCase>(
    () => ConfirmAccountUseCase(getIt<RegisterRepository>()),
  );
  getIt.registerLazySingleton<ResendConfirmationUseCase>(
    () => ResendConfirmationUseCase(getIt<RegisterRepository>()),
  );

  // ================= CUBIT =================

  getIt.registerFactory<RegisterCubit>(
    () => RegisterCubit(
      getIt<RegisterDriverUseCase>(),
      getIt<RegisterPassengerUseCase>(),
      getIt<VerifyOtpUseCase>(),
      getIt<ConfirmAccountUseCase>(),
      getIt<ResendConfirmationUseCase>(),
    ),
  );

  getIt.registerLazySingleton<LoginApiService>(
    () => LoginApiService(getIt<Dio>()),
  );
  getIt.registerLazySingleton<LoginRemoteDataSource>(
    () => LoginRemoteDataSourceImpl(getIt<LoginApiService>()),
  );
  getIt.registerLazySingleton<LoginRepo>(
    () => LoginRepoImpl(getIt<LoginRemoteDataSource>()),
  );
  getIt.registerFactory<LoginUseCase>(() => LoginUseCase(getIt<LoginRepo>()));
  getIt.registerFactory<ForgetPasswordUseCase>(
    () => ForgetPasswordUseCase(getIt<LoginRepo>()),
  );
  getIt.registerFactory<ResetPasswordUseCase>(
    () => ResetPasswordUseCase(getIt<LoginRepo>()),
  );
  getIt.registerFactory<LoginCubit>(
    () => LoginCubit(
      loginUseCase: getIt<LoginUseCase>(),
      forgetPasswordUseCase: getIt<ForgetPasswordUseCase>(),
      resetPasswordUseCase: getIt<ResetPasswordUseCase>(),
    ),
  );
}

void _driverDependencies() {
  getIt.registerLazySingleton<DriverHomeApiService>(
    () => DriverHomeApiService(getIt()),
  );

  // ================= DATA SOURCE =================

  getIt.registerLazySingleton<DriverHomeDataSource>(
    () => DriverHomeDataSourceImpl(getIt<DriverHomeApiService>()),
  );
  getIt.registerLazySingleton<QueueSignalRDataSource>(
    () => QueueSignalRDataSourceImpl(),
  );

  // ================= REPOSITORY =================

  getIt.registerLazySingleton<DriverHomeRepository>(
    () => DriverHomeRepositoryImpl(
      getIt<DriverHomeDataSource>(),
      getIt<QueueSignalRDataSource>(),
    ),
  );

  // ================= USE CASES =================

  getIt.registerLazySingleton<GetCurrentPositionUsecase>(
    () => GetCurrentPositionUsecase(getIt<DriverHomeRepository>()),
  );

  getIt.registerLazySingleton<GetTripHistoryUseCase>(
    () => GetTripHistoryUseCase(getIt<DriverHomeRepository>()),
  );
  getIt.registerLazySingleton<ListenToQueueNotificationsUseCase>(
    () => ListenToQueueNotificationsUseCase(getIt<DriverHomeRepository>()),
  );
  getIt.registerLazySingleton<GetStationQueueUseCase>(
    () => GetStationQueueUseCase(getIt<DriverHomeRepository>()),
  );
  getIt.registerLazySingleton<GetEstimatedDailyEarningsUseCase>(
    () => GetEstimatedDailyEarningsUseCase(getIt<DriverHomeRepository>()),
  );

  getIt.registerLazySingleton<ConnectQueue>(
    () => ConnectQueue(getIt<DriverHomeRepository>()),
  );
  getIt.registerLazySingleton<StartTripUseCase>(
    () => StartTripUseCase(getIt<DriverHomeRepository>()),
  );
  getIt.registerLazySingleton<EndTripUseCase>(
    () => EndTripUseCase(getIt<DriverHomeRepository>()),
  );

  // ================= CUBIT =================

  getIt.registerLazySingleton<DriverHomeCubit>(
    () => DriverHomeCubit(
      getIt<GetCurrentPositionUsecase>(),
      getIt<GetEstimatedDailyEarningsUseCase>(),
      getIt<GetStationQueueUseCase>(),
      getIt<GetTripHistoryUseCase>(),
      getIt<ListenToQueueNotificationsUseCase>(),
      getIt<ConnectQueue>(),
      getIt<StartTripUseCase>(),
      getIt<EndTripUseCase>(),
    ),
  );
  // ================= Passenger Dependencies =================
  getIt.registerLazySingleton<PassengerApiService>(
    () => PassengerApiService(getIt<Dio>()),
  );
  getIt.registerLazySingleton<PassengerRemoteDataSource>(
    () => PassengerRemoteDataSourceImpl(getIt<PassengerApiService>()),
  );
  getIt.registerLazySingleton<PassengerRepo>(
    () => PassengerRepoImpl(getIt<PassengerRemoteDataSource>()),
  );

  getIt.registerLazySingleton<GetRoutesUseCase>(
    () => GetRoutesUseCase(getIt<PassengerRepo>()),
  );

  getIt.registerLazySingleton<GetRouteDestinationUseCase>(
    () => GetRouteDestinationUseCase(getIt<PassengerRepo>()),
  );

  getIt.registerLazySingleton<GetRouteSummaryUseCase>(
    () => GetRouteSummaryUseCase(getIt<PassengerRepo>()),
  );

  getIt.registerLazySingleton<GetStationMicrobusesUseCase>(
    () => GetStationMicrobusesUseCase(getIt<PassengerRepo>()),
  );

  getIt.registerLazySingleton<GetOnTheWayMicrobusesUseCase>(
    () => GetOnTheWayMicrobusesUseCase(getIt<PassengerRepo>()),
  );
  // getIt.registerLazySingleton<GetReportReasonsUseCase>(
  //   () => GetReportReasonsUseCase(getIt<PassengerRepo>()),
  // )
  ;
  getIt.registerLazySingleton<AddRouteToFavouriteUseCase>(
    () => AddRouteToFavouriteUseCase(getIt<PassengerRepo>()),
  );
  getIt.registerLazySingleton<RemoveRouteFromFavUseCase>(
    () => RemoveRouteFromFavUseCase(getIt<PassengerRepo>()),
  );
  getIt.registerLazySingleton<IsRouteFavouriteUseCase>(
    () => IsRouteFavouriteUseCase(getIt<PassengerRepo>()),
  );
  getIt.registerLazySingleton<GetFavouriteRoutes>(
    () => GetFavouriteRoutes(getIt<PassengerRepo>()),
  );
  getIt.registerLazySingleton<SubmitReportUseCase>(
    () => SubmitReportUseCase(getIt<PassengerRepo>()),
  );
  getIt.registerLazySingleton<GetReportReasonsUseCase>(
    () => GetReportReasonsUseCase(getIt<PassengerRepo>()),
  );

  getIt.registerLazySingleton<UpdateReportUseCase>(
    () => UpdateReportUseCase(getIt<PassengerRepo>()),
  );
  getIt.registerLazySingleton<DeleteReportByIdUseCase>(
    () => DeleteReportByIdUseCase(getIt<PassengerRepo>()),
  );
  getIt.registerLazySingleton<GetAllReportsUseCase>(
    () => GetAllReportsUseCase(getIt<PassengerRepo>()),
  );
  getIt.registerLazySingleton<GetReportByIdUseCase>(
    () => GetReportByIdUseCase(getIt<PassengerRepo>()),
  );

  getIt.registerFactory<PassengerCubit>(
    () => PassengerCubit(
      getIt<GetRoutesUseCase>(),
      getIt<GetRouteDestinationUseCase>(),
      getIt<GetRouteSummaryUseCase>(),
      getIt<GetStationMicrobusesUseCase>(),
      getIt<GetOnTheWayMicrobusesUseCase>(),
      getIt<GetReportReasonsUseCase>(),
      getIt<SubmitReportUseCase>(),
      getIt<AddRouteToFavouriteUseCase>(),
      getIt<RemoveRouteFromFavUseCase>(),
      getIt<IsRouteFavouriteUseCase>(),
      getIt<GetFavouriteRoutes>(),
      getIt<GetAllReportsUseCase>(),
      getIt<GetReportByIdUseCase>(),
      getIt<DeleteReportByIdUseCase>(),
      getIt<UpdateReportUseCase>()
    ),
  );
}
