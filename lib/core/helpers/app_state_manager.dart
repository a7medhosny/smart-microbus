import '../../features/passener/presentation/cubit/passenger_cubit.dart';
import '../../features/Driver/driver_home/presentation/cubit/driver_home_cubit.dart';

class AppStateManager {
  static PassengerCubit? passengerCubit;
  static DriverHomeCubit? driverCubit;

  static void resetAll() {
    passengerCubit?.currentNavIndex = 0;
    driverCubit?.currentNavIndex = 0;
  }
}