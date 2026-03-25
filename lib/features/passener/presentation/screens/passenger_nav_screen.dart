import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_microbus/features/passener/presentation/cubit/passenger_cubit.dart';
import 'package:smart_microbus/features/passener/presentation/screens/favourite_screen.dart';
import 'package:smart_microbus/features/passener/presentation/screens/passenger_search_view.dart';
import 'package:smart_microbus/features/profile/presentation/screens/profile_screen.dart';

import '../../../../l10n/app_localizations.dart';

class PassengerNavigationScreen extends StatelessWidget {
  const PassengerNavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<PassengerCubit>();
        final l10n = AppLocalizations.of(context)!;


    final screens = const [
      PassengerSearchView(),
      FavoritesScreen(),
      ProfileScreen(),
    ];

    return BlocBuilder<PassengerCubit, PassengerState>(
      buildWhen: (prev, curr) => curr is ChangePassengerBottomNavState,
      builder: (context, state) {
        final currentIndex = cubit.currentNavIndex;

        return Scaffold(
          body: IndexedStack(
            index: currentIndex,
            children: screens,
          ),

          bottomNavigationBar: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: (index) {
              cubit.changeBottomNavIndex(index);
            },
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Theme.of(context).colorScheme.primary,
            items:  [
              BottomNavigationBarItem(
                icon: Icon(Icons.route),
                label: l10n.home,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: l10n.favoritesTitle,
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