import 'package:flutter/material.dart';
import 'package:smart_microbus/core/storage/cache_keys.dart';
import 'package:smart_microbus/features/passener/presentation/screens/navigation_screen.dart';
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
import 'package:smart_microbus/main.dart';

import '../../features/Driver/driver_home/presentation/cubit/driver_home_cubit.dart';
import '../../features/Driver/driver_home/presentation/screens/driver_home_page.dart';
import '../../features/Driver/driver_home/presentation/screens/driver_trip_history.dart';
import '../../features/passener/presentation/cubit/nav_cubit.dart';
import '../../features/passener/presentation/widgets/search_result_widgets/on_the_way_list_screen.dart';
import '../../features/passener/presentation/widgets/search_result_widgets/station_list_screen.dart';
import '../auth/token_manager.dart';
import '../config/app_config.dart';
import 'routes.dart';

// ================= IMPORT SCREENS =================
// Auth
// import 'package:smart_microbus/features/auth/login_screen.dart';

// Layout
// import 'package:smart_microbus/features/layout/layout_screen.dart';

class AppRouter {
  Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      // ================= INITIAL =================
      case Routes.initial:
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
      // case Routes.navigationScreen:
      //   return _materialRoute(MainNavigationScreen());
      case Routes.passengerSearch:
        return _materialRoute(PassengerSearchView());
      case Routes.passengerSearchResultScreen:
        return _materialRoute(const SearchResultScreen());
      case Routes.stationListScreen:
        final stationMicrobuses = settings.arguments as List;
        return _materialRoute(
          StationListScreen(stationMicrobuses: stationMicrobuses),
        );
      case Routes.onTheWayListScreen:
        final onTheWayMicrobuses = settings.arguments as List;
        return _materialRoute(OnTheWayListScreen(onTheWay: onTheWayMicrobuses));

      case Routes.navigationWrapper:
        return _materialRoute(
          BlocProvider(
            create: (context) => NavCubit(),
            child: const MainNavigationScreen(),
          ),
        );
      // ================= DEFAULT =================
      default:
        return null;
    }
  }

  // ================= HELPER =================
  MaterialPageRoute _materialRoute(Widget screen, {RouteSettings? settings}) {
    return MaterialPageRoute(builder: (_) => screen, settings: settings);
  }
}
