import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:smart_microbus/features/profile/presentation/screens/profile_screen.dart';
import 'package:smart_microbus/features/Driver/driver_home/presentation/screens/driver_home_page.dart';
import 'package:smart_microbus/features/Driver/driver_home/presentation/screens/driver_trip_history.dart';

import '../../../../../l10n/app_localizations.dart';
import '../cubit/driver_home_cubit.dart';

class DriverNavigationScreen extends StatelessWidget {
  const DriverNavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DriverHomeCubit>();
    final l10n = AppLocalizations.of(context)!;

    final screens = const [
      DriverHomeView(),
      DriverTripHistoryScreen(),
      ProfileScreen(),
    ];

    return BlocBuilder<DriverHomeCubit, DriverHomeState>(
      buildWhen: (prev, curr) => curr is ChangeDriverBottomNavState,
      builder: (context, state) {
        final currentIndex = cubit.currentNavIndex;

        return Scaffold(
          body: IndexedStack(index: currentIndex, children: screens),

          bottomNavigationBar: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: (index) {
              cubit.changeBottomNavIndex(index);
            },
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Theme.of(context).colorScheme.primary,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.directions_bus),
                label: l10n.home,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.history),
                label: l10n.tripHistory,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: l10n.profile,
              ),
            ],
          ),
        );
      },
    );
  }
}
