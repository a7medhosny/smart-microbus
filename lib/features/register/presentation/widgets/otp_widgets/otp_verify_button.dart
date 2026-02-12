import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/helpers/app_snack_bar.dart';
import '../../../../../core/routing/routes.dart';
import '../../../../../core/storage/cache_helper.dart';
import '../../../../../core/storage/cache_keys.dart';
import '../../../../../l10n/app_localizations.dart';
import '../../controllers/otp_controller.dart';
import '../../cubit/register_cubit.dart';

class OtpVerifyButton extends StatelessWidget {
  const OtpVerifyButton({
    super.key,
    required this.controller,
    required this.phoneNumber,
    required this.from,
  });

  final OtpController controller;
  final String phoneNumber;
  final String from;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        return BlocConsumer<RegisterCubit, RegisterState>(
          listener: (context, state) {
            // ---------------- VERIFY SUCCESS → CONFIRM ----------------

            if (state is VerifyOtpSuccess) {
              // Todo nav to reset password screen and save token , id
            }

            // ---------------- CONFIRM SUCCESS → NAVIGATE ----------------

            if (state is ConfirmAccountSuccess) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                Routes.login,
                (_) => false,
              );
            }
            if (state is ResendConfirmationError ||
                state is VerifyOtpError ||
                state is ConfirmAccountError) {
              final errorState = state as dynamic;
              showGlobalSnackBar(errorState.message);
            }
          },
          builder: (context, state) {
            final isLoading =
                state is VerifyOtpLoading || state is ConfirmAccountLoading;

            final canSubmit = controller.isCompleted && !isLoading;

            return SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: canSubmit
                    ? () {
                        if (from == CacheKeys.confirmAccount) {
                          context.read<RegisterCubit>().confirmAccount(
                            phoneNumber: phoneNumber,
                            otp: controller.otp,
                          );
                        } else {
                          context.read<RegisterCubit>().verifyOtp(
                            phoneNumber: phoneNumber,
                            otp: controller.otp,
                          );
                        }
                      }
                    : null,
                child: isLoading
                    ? const CircularProgressIndicator()
                    : Text(loc.verify),
              ),
            );
          },
        );
      },
    );
  }
}
