import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:smart_microbus/core/networking/dio_factory.dart';
import 'package:smart_microbus/features/Auth/login/data/datasource/login_api_service.dart';
import 'package:smart_microbus/features/Auth/login/data/datasource/login_remote_data_source.dart';
import 'package:smart_microbus/features/Auth/login/data/datasource/login_remote_data_source_impl.dart';
import 'package:smart_microbus/features/Auth/login/data/repos/login_repo._impl.dart';
import 'package:smart_microbus/features/Auth/login/domain/repos/login_repo.dart';
import 'package:smart_microbus/features/Auth/login/domain/usecases/forget_password_use_case.dart';
import 'package:smart_microbus/features/Auth/login/domain/usecases/login_use_case.dart';
import 'package:smart_microbus/features/Auth/login/presentation/cubit/cubit/login_cubit.dart';

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

  getIt.registerFactory<ThemeCubit>(() => ThemeCubit());
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
  getIt.registerFactory<LoginCubit>(
    () => LoginCubit(
      loginUseCase: getIt<LoginUseCase>(),
      forgetPasswordUseCase: getIt<ForgetPasswordUseCase>(),
    ),
  );
}
