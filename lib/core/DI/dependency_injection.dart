import 'package:get_it/get_it.dart';

import '../storage/cache_helper.dart';

import '../localization/locale_cubit.dart';
import '../localization/locale_storage.dart';

import '../theme/theme_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupDependencyInjection() async {
  // =========================
  // External
  // =========================

  await CacheHelper.cacheInitialization();

  // =========================
  // Storage / Services
  // =========================

  getIt.registerLazySingleton<LocaleStorage>(
    () => LocaleStorage(),
  );

  // =========================
  // Cubits
  // =========================

  getIt.registerFactory<LocaleCubit>(
    () => LocaleCubit(
      getIt<LocaleStorage>(),
    )..loadSavedLocale(),
  );

  getIt.registerFactory<ThemeCubit>(
    () => ThemeCubit(),
  );
}
