import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_microbus/core/di/dependency_injection.dart';
import 'package:smart_microbus/features/Auth/login/presentation/cubit/cubit/login_cubit.dart';
import 'package:smart_microbus/l10n/app_localizations.dart';

import '../../../../../core/storage/cache_keys.dart';
import '../../controllers/otp_controller.dart';
import '../../cubit/register_cubit.dart';

// ignore: must_be_immutable
class ResendCodeText extends StatelessWidget {
  ResendCodeText({
    super.key,
    required this.phoneNumber,
    required this.from,
    required this.controller,
  });

  final String phoneNumber;
  final String from;
  final OtpController controller;
  int seconds=60;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        return BlocBuilder<RegisterCubit, RegisterState>(
          builder: (context, state) {
            final isLoading = state is ResendConfirmationLoading;

            final canClick = controller.canResend && !isLoading;

            return TextButton(
              onPressed: canClick
                  ? () {
                      if (from == CacheKeys.confirmAccount) {
                        context.read<RegisterCubit>().resendConfirmation(
                          phoneNumber: phoneNumber,
                        );
                      } else {
                        getIt<LoginCubit>().forgetPassword(
                          phoneNumber: phoneNumber,
                        );
                      }
                      seconds *= 2;
                      // 👇 نعيد العداد
                      controller.resetResendTimer(seconds: seconds);
                    }
                  : null,
              child: isLoading
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text(
                      controller.canResend
                          ? loc.resendCode
                          : "${loc.resendCode} ${controller.formattedTime}",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
            );
          },
        );
      },
    );
  }
}
