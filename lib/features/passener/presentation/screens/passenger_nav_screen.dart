import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_microbus/core/routing/tab_router.dart';
import 'package:smart_microbus/features/passener/presentation/cubit/passenger_cubit.dart';

import '../../../../l10n/app_localizations.dart';

class PassengerNavigationScreen extends StatelessWidget {
  const PassengerNavigationScreen({super.key});

  Widget _buildTabNavigator(BuildContext context, int index) {
    final cubit = context.read<PassengerCubit>();

    return Navigator(
      key: cubit.navigatorKeys[index],
      onGenerateRoute: (settings) => TabRouter.generateRoute(
        settings: settings,
        tabIndex: index,
        type: AppTabType.passenger,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<PassengerCubit>();
    final l10n = AppLocalizations.of(context)!;

    return BlocBuilder<PassengerCubit, PassengerState>(
      buildWhen: (prev, curr) => curr is ChangePassengerBottomNavState,
      builder: (context, state) {
        final currentIndex = cubit.currentNavIndex;

        return PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, result) async {
            if (didPop) return;

            final navigator = cubit.navigatorKeys[currentIndex].currentState!;

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
                _buildTabNavigator(context, 3),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: currentIndex,
              onTap: (index) {
                if (index == currentIndex) {
                  cubit.navigatorKeys[index].currentState!.popUntil(
                    (route) => route.isFirst,
                  );
                } else {
                  cubit.changeBottomNavIndex(index);
                }
              },
              type: BottomNavigationBarType.fixed,
              items: [
                BottomNavigationBarItem(
                  icon: const Icon(Icons.route),
                  label: l10n.home,
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.favorite),
                  label: l10n.favoritesTitle,
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.report),
                  label: l10n.reports,
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
