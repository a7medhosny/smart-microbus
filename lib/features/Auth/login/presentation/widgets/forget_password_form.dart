import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_microbus/core/helpers/app_snack_bar.dart';
import 'package:smart_microbus/core/helpers/extensions.dart';
import 'package:smart_microbus/core/helpers/show_toast_helper.dart';
import 'package:smart_microbus/core/helpers/spacing.dart';
import 'package:smart_microbus/core/routing/routes.dart';
import 'package:smart_microbus/core/widgets/custom_text_field.dart';
import 'package:smart_microbus/features/Auth/login/domain/entites/forget_password_entity.dart';
import 'package:smart_microbus/features/Auth/login/presentation/cubit/cubit/login_cubit.dart';
import 'package:smart_microbus/l10n/app_localizations.dart';

class ForgetPasswordForm extends StatelessWidget {
  const ForgetPasswordForm({
    super.key,
    required this.controller,
    required this.formKey,
  });

  final TextEditingController controller;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Icon(
            Icons.lock_reset_rounded,
            size: 70,
            color: theme.colorScheme.primary,
          ),

          verticalSpace(20),

          Text(
            loc.forgetPasswordFormTitle,
            textAlign: TextAlign.center,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),

          verticalSpace(8),

          Text(
            loc.forgetPasswordFormDescription,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium,
          ),

          verticalSpace(40),
          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    CustomTextField(
                      labelText: loc.phoneNumber,
                      controller: controller,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return loc.phoneRequired;
                        }
                        return null;
                      },
                      hintText: loc.enterPhoneNumber,
                    ),
                  ],
                ),
              ),
            ),
          ),

          verticalSpace(24),
          BlocConsumer<LoginCubit, LoginState>(
            listener: (context, state) {
              if (state is ForgetPasswordLoading) {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (_) =>
                      const Center(child: CircularProgressIndicator()),
                );
              }

              if (state is ForgetPasswordFailure) {
                context.pop();
                if (state.message.contains("not confirmed")) {
                  ShowToastHelper.showToast(context, loc.phoneNotConfirmed);
                  // context.pushNamed(
                  //   Routes.confirmAccount,
                  //   arguments: controller.text,
                  // );
                }
                showGlobalSnackBar(state.message);
              }

              if (state is ForgetPasswordSuccess) {
                context.pop();
                ShowToastHelper.showToast(context, loc.otpSent);
                context.pushNamed(
                  Routes.resetPassword,
                  arguments: controller.text,
                );
              }
            },
            builder: (context, state) {
              return SizedBox(
                height: 52,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      context.read<LoginCubit>().forgetPassword(
                        entity: ForgetPasswordEntity(
                          phoneNumber: controller.text,
                        ),
                      );
                    }
                  },
                  child: Text(loc.sendResetCode),
                ),
              );
            },
          ),

          verticalSpace(16),

          TextButton(onPressed: () => context.pop(), child: Text(loc.loginNow)),
        ],
      ),
    );
  }
}
