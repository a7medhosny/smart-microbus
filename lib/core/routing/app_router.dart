import 'package:flutter/material.dart';
import 'package:smart_microbus/core/storage/cache_keys.dart';
import 'package:smart_microbus/features/Auth/welcome/views/home_screen.dart';

import 'package:smart_microbus/features/passener/domain/entities/on_the_way_microbus_entity.dart';

import 'package:smart_microbus/features/passener/presentation/screens/passenger_search_view.dart';
import 'package:smart_microbus/features/passener/presentation/screens/search_result_screen.dart';
import 'package:smart_microbus/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:smart_microbus/features/profile/presentation/screens/profile_screen.dart';
import 'package:smart_microbus/features/register/presentation/pages/register_screen.dart';
import 'package:smart_microbus/features/register/presentation/pages/verify_otp_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_microbus/core/DI/dependency_injection.dart';
import 'package:smart_microbus/features/Auth/login/presentation/cubit/cubit/login_cubit.dart';
import 'package:smart_microbus/features/Auth/login/presentation/screens/forgetp_password_screen.dart';
import 'package:smart_microbus/features/Auth/login/presentation/screens/login_Screen.dart';
import 'package:smart_microbus/features/Auth/login/presentation/screens/reset_password_screen.dart';
import 'package:smart_microbus/features/splash/views/splash_screen.dart';

import '../../features/Driver/driver_home/presentation/cubit/driver_home_cubit.dart';
import '../../features/Driver/driver_home/presentation/screens/driver_home_page.dart';
import '../../features/Driver/driver_home/presentation/screens/driver_nav_screen.dart';
import '../../features/Driver/driver_home/presentation/screens/driver_trip_history.dart';
import '../../features/passener/presentation/screens/all_report_screen.dart';
import '../../features/passener/presentation/screens/passenger_nav_screen.dart';
import '../../features/passener/presentation/screens/report_details_screen.dart';
import '../../features/passener/presentation/screens/report_screen.dart';
import '../../features/passener/presentation/widgets/search_result_widgets/on_the_way_list_screen.dart';
import '../../features/passener/presentation/widgets/search_result_widgets/station_list_screen.dart';
import 'routes.dart';

// ================= IMPORT SCREENS =================

class AppRouter {
  Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashScreen:
        return _materialRoute(const SplashScreen());
      // ================= INITIAL =================
      case Routes.homeScreen:
        return _materialRoute(const HomeScreen());

      // ================= LOGIN =================
      case Routes.login:
        return _materialRoute(
          BlocProvider(
            create: (context) => getIt<LoginCubit>(),
            child: const LoginScreen(),
          ),
        );

      // ================= forget password =================
      case Routes.forgotPassword:
        return _materialRoute(
          BlocProvider(
            create: (context) => getIt<LoginCubit>(),
            child: ForgetpPasswordScreen(),
          ),
        );

      case Routes.profile:
        return _materialRoute(
          BlocProvider(
            create: (context) => getIt<ProfileCubit>(),
            child: ProfileScreen(),
          ),
        );

      // ================= reset password =================
      case Routes.resetPassword:
        final args = settings.arguments as Map<String, dynamic>;
        final String phone = args[CacheKeys.phone];
        final String token = args[CacheKeys.token];
        final String userId = args[CacheKeys.userId];
        return _materialRoute(
          BlocProvider(
            create: (context) => getIt<LoginCubit>(),
            child: ResetPasswordScreen(
              phone: phone,
              token: token,
              userId: userId,
            ),
          ),
          settings: settings,
        );
      // ================= REGISTER =================
      case Routes.register:
        return _materialRoute(const RegisterScreen());

      // ================= OTP VERIFICATION =================
      case Routes.otpVerification:
        {
          final args = settings.arguments as Map<String, dynamic>;

          final String phoneNumber = args["phone"];
          final String from = args["from"];
          return _materialRoute(
            VerifyOtpScreen(phoneNumber: phoneNumber, from: from),
          );
        }
      // ================= Driver home =================
      case Routes.driverHome:
        return _materialRoute(
          BlocProvider.value(
            value: getIt<DriverHomeCubit>(),
            child: DriverHomeView(),
          ),
        );
      case Routes.driverTripHistory:
        return _materialRoute(
          BlocProvider.value(
            value: getIt<DriverHomeCubit>(),
            child: DriverTripHistoryScreen(),
          ),
        );

      // ================= Passenger  =================

      case Routes.passengerSearch:
        return _materialRoute(PassengerSearchView());
      case Routes.passengerSearchResultScreen:
        final String routeId = settings.arguments as String;
        return _materialRoute(SearchResultScreen(routeId: routeId));
      case Routes.stationListScreen:
        final stationMicrobuses = settings.arguments as List;
        return _materialRoute(
          StationListScreen(stationMicrobuses: stationMicrobuses),
        );
      case Routes.onTheWayListScreen:
        final onTheWayMicrobuses =
            settings.arguments as List<OnTheWayMicrobusEntity>;
        return _materialRoute(OnTheWayListScreen(onTheWay: onTheWayMicrobuses));

      case Routes.passengerNavigationScreen:
        return _materialRoute(PassengerNavigationScreen());

      case Routes.driverNavigationScreen:
        return _materialRoute(DriverNavigationScreen());
      case Routes.allReportScreen:
        return _materialRoute(AllReportScreen());
      case Routes.reportDetailsPage:
        final String reportId = settings.arguments as String;
        return _materialRoute(ReportDetailsPage(reportId: reportId));
      case Routes.reportPage:
        final String plateNumber = settings.arguments as String;
        return _materialRoute(ReportPage(plateNumber: plateNumber));
    }
    return null;
  }

  // ================= HELPER =================
  MaterialPageRoute _materialRoute(Widget screen, {RouteSettings? settings}) {
    return MaterialPageRoute(builder: (_) => screen, settings: settings);
  }
}
