import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:smart_microbus/core/helpers/extensions.dart';
import 'package:smart_microbus/core/routing/routes.dart';
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
        BlocProvider(create: (_) => getIt<LocaleCubit>()),
        BlocProvider(create: (_) => getIt<ThemeCubit>()),
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
            Text(tr.login, style: Theme.of(context).textTheme.headlineMedium),

            const SizedBox(height: 24),

            ElevatedButton(
              onPressed: () {
                localeCubit.toEnglish();
              },
              child: const Text("English"),
            ),

            const SizedBox(height: 12),

            ElevatedButton(
              onPressed: () {
                localeCubit.toArabic();
              },
              child: const Text("العربية"),
            ),

            const SizedBox(height: 24),

            ElevatedButton(
              onPressed: () {
                context.pushNamed(Routes.login);
              },
              child: const Text("Login"),
            ),
          ],
        ),
      ),
    );
  }
}
