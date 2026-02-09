import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  });

  final OtpController controller;
  final String phoneNumber;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        return BlocConsumer<RegisterCubit, RegisterState>(
          listener: (context, state) {
            if (state is VerifyOtpSuccess) {
              CacheHelper.deleteCacheItem(key: CacheKeys.otpFlowActive);
              CacheHelper.deleteCacheItem(key: CacheKeys.otpPhone);
              Navigator.pushNamedAndRemoveUntil(context, "/home", (_) => false);
            }
          },
          builder: (context, state) {
            final isLoading = state is VerifyOtpLoading;

            final canSubmit = controller.isCompleted && !isLoading;

            return SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: canSubmit
                    ? () {
                        context.read<RegisterCubit>().verifyOtp(
                          phoneNumber: phoneNumber,
                          otp: controller.otp,
                        );
                      }
                    : null, // ❌ Disabled
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
