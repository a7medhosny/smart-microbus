// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:smart_microbus/core/auth/token_manager.dart';
// import 'package:smart_microbus/features/Driver/driver_home/presentation/screens/driver_home_page.dart';
// import 'package:smart_microbus/features/Driver/driver_home/presentation/screens/driver_trip_history.dart';
// import 'package:smart_microbus/features/passener/presentation/screens/favourite_screen.dart';
// import 'package:smart_microbus/features/passener/presentation/screens/passenger_search_view.dart';
// import 'package:smart_microbus/features/profile/presentation/screens/profile_screen.dart';

// part 'nav_state.dart';

// class NavCubit extends Cubit<NavState> {
//   NavCubit() : super(NavInitial()) {
//     _setupNav();
//   }

//   int currentIndex = 0;

//   late List<Widget> screens;

//   void _setupNav() {
//     final role = TokenManager.role ?? 'Passenger';

//     if (role == 'Driver') {
//       screens = const [
//         DriverHomeView(),
//         DriverTripHistoryScreen(),
//         ProfileScreen(),
//       ];
//     } else {
//       /// Passenger
//       screens = const [
//         PassengerSearchView(),
//         FavoritesScreen(),
//         ProfileScreen(),
//       ];
//     }
//   }

//   void changeIndex(int index) {
//     currentIndex = index;
//     emit(NavChanged());
//   }
// }