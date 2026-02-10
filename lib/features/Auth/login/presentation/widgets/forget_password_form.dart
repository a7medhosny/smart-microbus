import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_microbus/core/helpers/app_snack_bar.dart';
import 'package:smart_microbus/core/helpers/extensions.dart';
import 'package:smart_microbus/core/helpers/spacing.dart';
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
            style: theme.textTheme.headlineMedium?.copyWith(
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
                showGlobalSnackBar(state.message);
              }

              if (state is ForgetPasswordSuccess) {
                context.pop();
                showGlobalSnackBar(loc.passwordResetSent);
              }
            },
            builder: (context, state) {
              final isLoading = state is ForgetPasswordLoading;

              return SizedBox(
                height: 52,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isLoading
                      ? null
                      : () {
                          if (formKey.currentState!.validate()) {
                            context.read<LoginCubit>().forgetPassword(
                              entity: ForgetPasswordEntity(
                                phoneNumber: controller.text,
                              ),
                            );
                          }
                        },
                  child: isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text(loc.sendResetLink),
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
