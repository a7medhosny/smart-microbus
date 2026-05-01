import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_microbus/core/routing/tab_router.dart';
import 'package:smart_microbus/features/Driver/driver_home/presentation/cubit/driver_home_cubit.dart';

import '../../../../../l10n/app_localizations.dart';

class DriverNavigationScreen extends StatelessWidget {
  const DriverNavigationScreen({super.key});

  Widget _buildTabNavigator(BuildContext context, int index) {
    final cubit = context.read<DriverHomeCubit>();

    return Navigator(
      key: cubit.navKeys[index],
      onGenerateRoute: (settings) => TabRouter.generateRoute(
        settings: settings,
        tabIndex: index,
        type: AppTabType.driver,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DriverHomeCubit>();
    final l10n = AppLocalizations.of(context)!;

    return BlocBuilder<DriverHomeCubit, DriverHomeState>(
      buildWhen: (prev, curr) => curr is ChangeDriverBottomNavState,
      builder: (context, state) {
        final currentIndex = cubit.currentNavIndex;

        return PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, result) async {
            if (didPop) return;

            final navigator = cubit.navKeys[currentIndex].currentState!;

            if (navigator.canPop()) {
              navigator.pop();
            } else {
              if (currentIndex != 0) {
                cubit.changeBottomNavIndex(0);
              } else {
                SystemNavigator.pop();
              }
            }
          },
          child: Scaffold(
            body: IndexedStack(
              index: currentIndex,
              children: [
                _buildTabNavigator(context, 0),
                _buildTabNavigator(context, 1),
                _buildTabNavigator(context, 2),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: currentIndex,
              onTap: (index) {
                if (index == currentIndex) {
                  cubit.navKeys[index].currentState!.popUntil(
                    (route) => route.isFirst,
                  );
                } else {
                  cubit.changeBottomNavIndex(index);
                }
              },
              items: [
                BottomNavigationBarItem(
                  icon: const Icon(Icons.directions_bus),
                  label: l10n.home,
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.history),
                  label: l10n.tripHistory,
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.person),
                  label: l10n.profile,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
