import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:smart_microbus/core/helpers/extensions.dart';
import 'package:smart_microbus/core/networking/dio_factory.dart';
import 'package:smart_microbus/core/routing/routes.dart';
import 'package:smart_microbus/core/services/noification_servises.dart';
import 'package:smart_microbus/features/passener/presentation/cubit/passenger_cubit.dart';
import 'package:smart_microbus/features/register/presentation/cubit/register_cubit.dart';
import 'package:smart_microbus/l10n/app_localizations.dart';

import 'core/auth/token_manager.dart';
import 'core/di/dependency_injection.dart';
import 'core/localization/locale_cubit.dart';
import 'core/localization/locale_state.dart';
import 'core/routing/app_router.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_cubit.dart';
import 'features/passener/data/datasource/passenger_api_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// 🔥 Initialize Dependency Injection
  await setupDependencyInjection();
  await NotificationService.init();
  await NotificationService.requestPermission();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appRouter = AppRouter();
    final bool isLoggedIn = TokenManager.token != null;
    final bool isDriver = TokenManager.role == 'Driver';
    print('Is Logged In: $isLoggedIn, Role: ${TokenManager.role}');
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<LocaleCubit>()),
        BlocProvider(create: (_) => getIt<ThemeCubit>()),
        BlocProvider(create: (_) => getIt<RegisterCubit>()),
        BlocProvider(create: (_) => getIt<PassengerCubit>()),
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
                    initialRoute: isLoggedIn
                        ? isDriver
                              ? Routes.driverHome
                              : Routes.passengerSearch
                        : Routes.initial,
                    // Set initial route based on login state
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

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localeCubit = context.read<LocaleCubit>();
    final themeCubit = context.read<ThemeCubit>();
    final tr = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          tr.appName,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: themeCubit.toggleTheme,
            icon: const Icon(Icons.dark_mode_rounded),
          ),
        ],
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /// LOGO / ICON
              Container(
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: theme.colorScheme.primary.withOpacity(.1),
                ),
                child: Icon(
                  Icons.directions_bus_rounded,
                  size: 70,
                  color: theme.colorScheme.primary,
                ),
              ),

              const SizedBox(height: 25),

              /// APP NAME
              Text(
                tr.welcomeToMinya,
                textAlign: TextAlign.center,
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                tr.chooseRoleDescription,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium,
              ),

              const SizedBox(height: 40),

              /// LOGIN BUTTON
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    context.pushNamed(Routes.login);
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(tr.login, style: const TextStyle(fontSize: 16)),
                ),
              ),

              const SizedBox(height: 20),

              /// Register BUTTON
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    context.pushNamed(Routes.register);
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    tr.register,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              /// LANGUAGE SWITCH
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                    onPressed: localeCubit.toEnglish,
                    child: const Text("English"),
                  ),
                  const SizedBox(width: 12),
                  OutlinedButton(
                    onPressed: localeCubit.toArabic,
                    child: const Text("العربية"),
                  ),
                ],
              ),
              // ElevatedButton(
              //   onPressed: () {
              //     NotificationService.showNotification(
              //       title: 'notification',
              //       body: 'fjifjijr',
              //     );
              //   },
              //   style: ElevatedButton.styleFrom(
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(16),
              //     ),
              //   ),
              //   child: Text(
              //     'send notification',
              //     style: const TextStyle(fontSize: 16),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
