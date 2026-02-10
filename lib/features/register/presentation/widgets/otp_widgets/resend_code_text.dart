import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_microbus/l10n/app_localizations.dart';

import '../../controllers/otp_controller.dart';
import '../../cubit/register_cubit.dart';

class ResendCodeText extends StatelessWidget {
  const ResendCodeText({
    super.key,
    required this.phoneNumber,
    required this.controller,
  });

  final String phoneNumber;
  final OtpController controller;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        return BlocBuilder<
            RegisterCubit,
            RegisterState>(
          builder: (context, state) {
            final isLoading =
                state is ResendConfirmationLoading;

            final canClick =
                controller.canResend &&
                    !isLoading;

            return TextButton(
              onPressed: canClick
                  ? () {
                      context
                          .read<
                              RegisterCubit>()
                          .resendConfirmation(
                            phoneNumber:
                                phoneNumber,
                          );

                      // 👇 نعيد العداد
                      controller
                          .resetResendTimer();
                    }
                  : null,
              child: isLoading
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child:
                          CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    )
                  : Text(
                      controller.canResend
                          ? loc.resendCode
                          : "${loc.resendCode} ${controller.formattedTime}",
                      style: TextStyle(
                        color: Theme.of(
                                context)
                            .colorScheme
                            .primary,
                      ),
                    ),
            );
          },
        );
      },
    );
  }
}

