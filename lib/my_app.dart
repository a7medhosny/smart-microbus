import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_microbus/core/localization/locale_cubit.dart';
import 'package:smart_microbus/core/localization/locale_state.dart';
import 'package:smart_microbus/core/networking/dio_factory.dart';
import 'package:smart_microbus/core/routing/app_router.dart';
import 'package:smart_microbus/core/theme/app_theme.dart';
import 'package:smart_microbus/core/theme/theme_cubit.dart';
import 'package:smart_microbus/features/Auth/login/presentation/cubit/cubit/login_cubit.dart';
import 'package:smart_microbus/features/maps/presentation/cubit/map_cubit.dart';
import 'package:smart_microbus/features/passener/presentation/cubit/passenger_location_cubit.dart';
import 'package:smart_microbus/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:smart_microbus/features/register/presentation/cubit/register_cubit.dart';
import 'package:smart_microbus/l10n/app_localizations.dart';

import 'core/DI/dependency_injection.dart';
import 'core/auth/session_manager.dart';
import 'core/auth/token_manager.dart';
import 'core/helpers/app_state_manager.dart';
import 'core/routing/routes.dart';
import 'core/storage/cache_helper.dart';
import 'core/storage/cache_keys.dart';
import 'features/Driver/driver_home/presentation/cubit/driver_home_cubit.dart';
import 'features/on_boarding/presentation/cubit/onboarding_cubit.dart';
import 'features/passener/presentation/cubit/passenger_cubit.dart';
import 'features/staff_qr/presentation/cubit/staff_qr_cubit.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.sessionState});

  final SessionState sessionState;

  @override
  Widget build(BuildContext context) {
    String initialRoute;

    final appRouter = AppRouter();
    // final bool isLoggedIn = TokenManager.token != null;
    final bool isDriver = TokenManager.role == 'Driver';
    final passengerCubit = getIt<PassengerCubit>();
    final driverCubit = getIt<DriverHomeCubit>();
    AppStateManager.passengerCubit = passengerCubit;
    AppStateManager.driverCubit = driverCubit;
    final bool isOnboardingCompleted =
        CacheHelper.getCacheData(key: CacheKeys.onboardingKey) == 'true';
    switch (sessionState) {
      case SessionState.guest:
        initialRoute = Routes.passengerNavigationScreen;

        break;

      case SessionState.authenticated:
        initialRoute = isDriver
            ? Routes.driverNavigationScreen
            : Routes.passengerNavigationScreen;

        break;

      case SessionState.unauthenticated:
        initialRoute = isOnboardingCompleted
            ? Routes.homeScreen
            : Routes.onboarding;

        break;
    }
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<LocaleCubit>()),
        BlocProvider(create: (_) => getIt<ThemeCubit>()),
        BlocProvider(create: (_) => getIt<RegisterCubit>()),
        BlocProvider(create: (_) => getIt<LoginCubit>()),
        BlocProvider(create: (_) => passengerCubit),
        BlocProvider(create: (_) => getIt<ProfileCubit>()),
        BlocProvider(create: (_) => getIt<MapCubit>()..initialize()),
        BlocProvider(create: (_) => getIt<PassengerLocationCubit>()),
        BlocProvider(create: (_) => getIt<OnboardingCubit>()),
        // BlocProvider(create: (_) => getIt<StaffQrCubit>()),
        BlocProvider(create: (_) => driverCubit),
      ],
      child: BlocBuilder<LocaleCubit, LocaleState>(
        builder: (context, localeState) {
          return BlocBuilder<ThemeCubit, ThemeMode>(
            builder: (context, themeMode) {
              return ScreenUtilInit(
                designSize: const Size(375, 812),
                minTextAdapt: true,
                splitScreenMode: true,

                builder: (context, child) {
                  return MaterialApp(
                    debugShowCheckedModeBanner: false,
                    navigatorKey: navigatorKey,
                    onGenerateRoute: appRouter.onGenerateRoute,
                    initialRoute: Routes.splashScreen,
                    // ================= Localization =================
                    locale: localeState.locale,
                    supportedLocales: AppLocalizations.supportedLocales,
                    localizationsDelegates: const [
                      AppLocalizations.delegate,
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                      GlobalCupertinoLocalizations.delegate,
                    ],

                    // ================= Themes =================
                    theme: AppTheme.lightTheme,
                    darkTheme: AppTheme.darkTheme,
                    themeMode: themeMode,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
