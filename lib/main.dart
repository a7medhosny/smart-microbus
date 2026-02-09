import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:smart_microbus/core/networking/dio_factory.dart';
import 'package:smart_microbus/core/routing/routes.dart';
import 'package:smart_microbus/features/register/presentation/cubit/register_cubit.dart';
import 'package:smart_microbus/l10n/app_localizations.dart';

import 'core/di/dependency_injection.dart';

import 'core/localization/locale_cubit.dart';
import 'core/localization/locale_state.dart';

import 'core/routing/app_router.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// 🔥 Initialize Dependency Injection
  await setupDependencyInjection();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appRouter = AppRouter();

    return MultiBlocProvider(
      providers: [
        /// 🌍 Localization Cubit
        BlocProvider(create: (_) => getIt<LocaleCubit>()),

        /// 🎨 Theme Cubit
        BlocProvider(create: (_) => getIt<ThemeCubit>()),
        BlocProvider(create: (_) => getIt<RegisterCubit>()),
      ],

      child: BlocBuilder<LocaleCubit, LocaleState>(
        builder: (context, localeState) {
          return BlocBuilder<ThemeCubit, ThemeMode>(
            builder: (context, themeMode) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                navigatorKey: navigatorKey,
                onGenerateRoute: appRouter.onGenerateRoute,
                initialRoute: Routes.initial,

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

    return Scaffold(
      appBar: AppBar(
        title: Text(tr.welcomeToMinya),
        centerTitle: true,

        /// 🌙 Toggle Theme Icon
        actions: [
          IconButton(
            onPressed: () {
              themeCubit.toggleTheme();
            },
            icon: const Icon(Icons.dark_mode),
          ),
        ],
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// 🌍 Translated Text
            Text(tr.login, style: Theme.of(context).textTheme.headlineMedium),

            const SizedBox(height: 24),

            /// 🇬🇧 English
            ElevatedButton(
              onPressed: () {
                localeCubit.toEnglish();
              },
              child: const Text("English"),
            ),

            const SizedBox(height: 12),

            /// 🇸🇦 Arabic
            ElevatedButton(
              onPressed: () {
                localeCubit.toArabic();
              },
              child: const Text("العربية"),
            ),
            const SizedBox(height: 12),

            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, Routes.register);
              },
              child: Text(tr.register),
            ),
            const SizedBox(height: 12),

            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  Routes.otpVerification,
                  arguments: '01110718472',
                );
              },
              child: Text(tr.verify),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
