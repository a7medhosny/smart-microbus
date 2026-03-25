// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:smart_microbus/core/auth/token_manager.dart';
// import 'package:smart_microbus/l10n/app_localizations.dart';

// import '../cubit/nav_cubit.dart';

// class MainNavigationScreen extends StatelessWidget {
//   const MainNavigationScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final cubit = context.read<NavCubit>();
//     final l10n = AppLocalizations.of(context)!;
//     final role = TokenManager.role ?? 'Passenger';

//     return BlocBuilder<NavCubit, NavState>(
//       buildWhen: (prev, curr) => curr is NavChanged,
//       builder: (context, state) {
//         /// 👇 هنا بنحدد الـ items حسب ال role
//         final items = role == 'Driver'
//             ? [
//                 BottomNavigationBarItem(
//                   icon: const Icon(Icons.home),
//                   label: l10n.home,
//                 ),
//                 BottomNavigationBarItem(
//                   icon: const Icon(Icons.directions_bus),
//                   label: l10n.trips,
//                 ),
//                 BottomNavigationBarItem(
//                   icon: const Icon(Icons.person),
//                   label: l10n.profile,
//                 ),
//               ]
//             : [
//                 BottomNavigationBarItem(
//                   icon: const Icon(Icons.route),
//                   label: l10n.home,
//                 ),
//                 BottomNavigationBarItem(
//                   icon: const Icon(Icons.favorite),
//                   label: l10n.favoritesTitle,
//                 ),
//                 BottomNavigationBarItem(
//                   icon: const Icon(Icons.person),
//                   label: l10n.profile,
//                 ),
//               ];

//         return Scaffold(
//           body: IndexedStack(
//             index: cubit.currentIndex,
//             children: cubit.screens,
//           ),
//           bottomNavigationBar: BottomNavigationBar(
//             currentIndex: cubit.currentIndex,
//             onTap: cubit.changeIndex,
//             type: BottomNavigationBarType.fixed,
//             selectedItemColor: Theme.of(context).colorScheme.primary,
//             items: items,
//           ),
//         );
//       },
//     );
//   }
// }