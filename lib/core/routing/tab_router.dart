import 'package:flutter/material.dart';
// //Auth
import 'package:smart_microbus/core/routing/routes.dart';
import 'package:smart_microbus/features/passener/presentation/screens/all_report_screen.dart';


// Passenger
import 'package:smart_microbus/features/passener/presentation/screens/passenger_search_view.dart';
import 'package:smart_microbus/features/passener/presentation/screens/favourite_screen.dart';
import 'package:smart_microbus/features/passener/presentation/screens/report_details_screen.dart';
import 'package:smart_microbus/features/passener/presentation/screens/search_result_screen.dart';
import 'package:smart_microbus/features/passener/presentation/widgets/search_result_widgets/station_list_screen.dart';
import 'package:smart_microbus/features/passener/presentation/widgets/search_result_widgets/on_the_way_list_screen.dart';

// Driver
import 'package:smart_microbus/features/Driver/driver_home/presentation/screens/driver_home_page.dart';
import 'package:smart_microbus/features/Driver/driver_home/presentation/screens/driver_trip_history.dart';

// Shared
import 'package:smart_microbus/features/profile/presentation/screens/profile_screen.dart';

import '../../features/passener/presentation/screens/report_screen.dart';

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
            return _route(const AllReportScreen());
          case 3:
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
      case Routes.reportDetailsPage:
        final routeId = settings.arguments as String;
        return _route(ReportDetailsPage(reportId: routeId));

      case Routes.reportPage:
        final plateNumber = settings.arguments as String;
        return _route(ReportPage(plateNumber: plateNumber));

      /// Driver 
      case Routes.driverTripHistory:
        return _route(const DriverTripHistoryScreen());
     
      default:
        return null;
    }
  }

  static MaterialPageRoute _route(Widget screen) {
    return MaterialPageRoute(builder: (_) => screen);
  }
}
