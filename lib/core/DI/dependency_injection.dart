import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:smart_microbus/core/networking/dio_factory.dart';
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
