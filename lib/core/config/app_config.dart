import 'package:flutter/material.dart';
import 'package:smart_microbus/features/Driver/driver_home/presentation/screens/driver_home_page.dart';
import 'package:smart_microbus/features/Driver/driver_home/presentation/screens/driver_trip_history.dart';

import '../../features/passener/presentation/screens/favourite_screen.dart';
import '../../features/passener/presentation/screens/passenger_search_view.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';
import '../../l10n/app_localizations.dart';

class AppConfig {
  static bool useMockData = true;
}

class PassengerNavConfig {
  static (List<Widget>, List<BottomNavigationBarItem>) build(
    BuildContext context,
  ) {
    final l10n = AppLocalizations.of(context)!;

    return (
      [
        const PassengerSearchView(),
        const FavoritesScreen(),
        const ProfileScreen(),
      ],
      [
        BottomNavigationBarItem(
          icon: const Icon(Icons.route),
          label: l10n.home,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.favorite),
          label: l10n.favoritesTitle,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.person),
          label: l10n.profile,
        ),
      ],
    );
  }
}

class DriverNavConfig {
  static (List<Widget>, List<BottomNavigationBarItem>) build(
    BuildContext context,
  ) {
    final l10n = AppLocalizations.of(context)!;

    return (
      [
        const DriverHomeView(),
        const DriverTripHistoryScreen(),
        const ProfileScreen(),
      ],
      [
        BottomNavigationBarItem(icon: const Icon(Icons.home), label: l10n.home),
        BottomNavigationBarItem(
          icon: const Icon(Icons.directions_bus),
          label: l10n.trips,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.person),
          label: l10n.profile,
        ),
      ],
    );
  }
}
