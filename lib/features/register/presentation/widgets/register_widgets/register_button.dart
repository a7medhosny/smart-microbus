import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_microbus/core/routing/routes.dart';

import '../../../../../core/storage/cache_helper.dart';
import '../../../../../core/storage/cache_keys.dart';
import '../../../../../l10n/app_localizations.dart';
import '../../controllers/register_controllers.dart';
import '../../cubit/register_cubit.dart';

class RegisterButton extends StatelessWidget {
  const RegisterButton({super.key, required this.controllers});

  final RegisterControllers controllers;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        // ================= SUCCESS NAVIGATION =================

        if (state is RegisterPassengerSuccess) {
          _goToOtp(context);
        }

        if (state is RegisterDriverSuccess) {
          _goToOtp(context);
        }
      },
      builder: (context, state) {
        final isLoading =
            state is RegisterPassengerLoading || state is RegisterDriverLoading;

        return SizedBox(
          width: double.infinity,
          height: 52,
          child: ElevatedButton(
            onPressed: isLoading
                ? null
                : () {
                    if (!controllers.formKey.currentState!.validate()) {
                      return;
                    }

                    final cubit = context.read<RegisterCubit>();

                    if (controllers.userType == RegisterUserType.passenger) {
                      cubit.registerPassenger(
                        name: controllers.fullNameController.text,
                        phoneNumber: controllers.phoneController.text,
                        password: controllers.passwordController.text,
                      );
                    } else {
                      cubit.registerDriver(
                        displayName: controllers.fullNameController.text,
                        phoneNumber: controllers.phoneController.text,
                        password: controllers.passwordController.text,
                        licenseNumber: controllers.licenseNumberController.text,
                      );
                    }
                  },
            child: isLoading
                ? const CircularProgressIndicator()
                : Text(loc.register),
          ),
        );
      },
    );
  }

  // ================= NAVIGATION =================

 void _goToOtp(BuildContext context) async {
  await CacheHelper.insertToCache(
    key: CacheKeys.otpFlowActive,
    value: 'true',
  );

  await CacheHelper.insertToCache(
    key: CacheKeys.otpPhone,
    value:
        controllers.phoneController.text,
  );

  Navigator.pushNamed(
    context,
    Routes.otpVerification,
    arguments: {
      "phone":
          controllers.phoneController.text,
    },
  );
}

}
