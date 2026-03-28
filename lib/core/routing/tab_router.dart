import 'package:flutter/material.dart';
// //Auth
import 'package:smart_microbus/core/routing/routes.dart';
// import 'package:smart_microbus/core/storage/cache_keys.dart';
// import 'package:smart_microbus/features/profile/presentation/cubit/profile_cubit.dart';
// import 'package:smart_microbus/features/register/presentation/pages/register_screen.dart';
// import 'package:smart_microbus/features/register/presentation/pages/verify_otp_screen.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:smart_microbus/core/DI/dependency_injection.dart';
// import 'package:smart_microbus/features/Auth/login/presentation/cubit/cubit/login_cubit.dart';
// import 'package:smart_microbus/features/Auth/login/presentation/screens/forgetp_password_screen.dart';
// import 'package:smart_microbus/features/Auth/login/presentation/screens/login_Screen.dart';
// import 'package:smart_microbus/features/Auth/login/presentation/screens/reset_password_screen.dart';

// Passenger
import 'package:smart_microbus/features/passener/presentation/screens/passenger_search_view.dart';
import 'package:smart_microbus/features/passener/presentation/screens/favourite_screen.dart';
import 'package:smart_microbus/features/passener/presentation/screens/search_result_screen.dart';
import 'package:smart_microbus/features/passener/presentation/widgets/search_result_widgets/station_list_screen.dart';
import 'package:smart_microbus/features/passener/presentation/widgets/search_result_widgets/on_the_way_list_screen.dart';

// Driver
import 'package:smart_microbus/features/Driver/driver_home/presentation/screens/driver_home_page.dart';
import 'package:smart_microbus/features/Driver/driver_home/presentation/screens/driver_trip_history.dart';

// Shared
import 'package:smart_microbus/features/profile/presentation/screens/profile_screen.dart';

enum AppTabType { passenger, driver }

class TabRouter {
  static Route<dynamic>? generateRoute({
    required RouteSettings settings,
    required int tabIndex,
    required AppTabType type,
  }) {
    /// ================= ROOT =================
    if (settings.name == '/' || settings.name == null) {
      if (type == AppTabType.passenger) {
        switch (tabIndex) {
          case 0:
            return _route(const PassengerSearchView());
          case 1:
            return _route(const FavoritesScreen());
          case 2:
            return _route(const ProfileScreen());
        }
      }

      if (type == AppTabType.driver) {
        switch (tabIndex) {
          case 0:
            return _route(const DriverHomeView());
          case 1:
            return _route(const DriverTripHistoryScreen());
          case 2:
            return _route(const ProfileScreen());
        }
      }
      return null;
    }

    /// ================= COMMON ROUTES =================
    switch (settings.name) {
      /// Passenger
      case Routes.passengerSearchResultScreen:
        final routeId = settings.arguments as String;
        return _route(SearchResultScreen(routeId: routeId));

      case Routes.stationListScreen:
        final stationMicrobuses = settings.arguments as List;
        return _route(StationListScreen(stationMicrobuses: stationMicrobuses));

      case Routes.onTheWayListScreen:
        final onTheWay = settings.arguments as List;
        return _route(OnTheWayListScreen(onTheWay: onTheWay));

      /// Driver (لو هتزود بعدين)
      case Routes.driverTripHistory:
        return _route(const DriverTripHistoryScreen());
      // case Routes.login:
      //   return _route(
      //     BlocProvider(
      //       create: (context) => getIt<LoginCubit>(),
      //       child: const LoginScreen(),
      //     ),
      //   );

      // // ================= forget password =================
      // case Routes.forgotPassword:
      //   return _route(
      //     BlocProvider(
      //       create: (context) => getIt<LoginCubit>(),
      //       child: ForgetpPasswordScreen(),
      //     ),
      //   );

      // case Routes.profile:
      //   return _route(
      //     BlocProvider(
      //       create: (context) => getIt<ProfileCubit>(),
      //       child: ProfileScreen(),
      //     ),
      //   );

      // // ================= reset password =================
      // case Routes.resetPassword:
      //   final args = settings.arguments as Map<String, dynamic>;
      //   final String phone = args[CacheKeys.phone];
      //   final String token = args[CacheKeys.token];
      //   final String userId = args[CacheKeys.userId];
      //   return _route(
      //     BlocProvider(
      //       create: (context) => getIt<LoginCubit>(),
      //       child: ResetPasswordScreen(
      //         phone: phone,
      //         token: token,
      //         userId: userId,
      //       ),
      //     ),
      //   );
      // // ================= REGISTER =================
      // case Routes.register:
      //   return _route(const RegisterScreen());

      // // ================= OTP VERIFICATION =================
      // case Routes.otpVerification:
      //   {
      //     final args = settings.arguments as Map<String, dynamic>;

      //     final String phoneNumber = args["phone"];
      //     final String from = args["from"];
      //     return _route(VerifyOtpScreen(phoneNumber: phoneNumber, from: from));
      //   }

      // case Routes.passengerNavigationScreen:
      //   return _route(PassengerNavigationScreen());

      // case Routes.driverNavigationScreen:
      //   return _route(DriverNavigationScreen());
      default:
        return null;
    }
  }

  static MaterialPageRoute _route(Widget screen) {
    return MaterialPageRoute(builder: (_) => screen);
  }
}
