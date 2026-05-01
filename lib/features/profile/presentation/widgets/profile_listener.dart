
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_microbus/core/helpers/show_toast_helper.dart';
import 'package:smart_microbus/features/profile/presentation/cubit/profile_state.dart';

import '../../../../core/auth/token_manager.dart';
import '../../../../core/networking/dio_factory.dart';
import '../../../../core/routing/routes.dart';
import '../../../Driver/driver_home/presentation/cubit/driver_home_cubit.dart';
import '../../../passener/presentation/cubit/passenger_cubit.dart';
import '../cubit/profile_cubit.dart';

class ProfileListener extends StatelessWidget {
  const ProfileListener({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is LogoutSuccess) {
          
          ShowToastHelper.showToast(context, 'Logout successful');
          TokenManager.clearLoginData();

    DioFactory.removeAuthInterceptor();

 
          context.read<PassengerCubit>().currentNavIndex = 0;
          context.read<DriverHomeCubit>().currentNavIndex = 0;
          navigatorKey.currentState!.pushNamedAndRemoveUntil(
            Routes.login,
            (route) => false,
          );
        } else if (state is ProfileDeleteAccountSuccess) {
          ShowToastHelper.showToast(context, state.message);
          TokenManager.clearLoginData();
              DioFactory.removeAuthInterceptor();

          navigatorKey.currentState!.pushNamedAndRemoveUntil(
            Routes.register,
            (route) => false,
          );
        } else if (state is ProfilePhotoDeleteSuccess) {
          ShowToastHelper.showToast(context, state.message);
        }
        if (state is ProfilePhotoUploadError ||
            state is ProfilePhotoDeleteError) {
          ShowToastHelper.showToast(
            context,
            state is ProfilePhotoUploadError
                ? state.message
                : (state as ProfilePhotoDeleteError).message,
            backgroundColor: Colors.red,
          );
        }
      },
      child: child,
    );
  }
}
