import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_microbus/core/helpers/app_snack_bar.dart';
import 'package:smart_microbus/core/helpers/extensions.dart';
import 'package:smart_microbus/core/helpers/show_toast_helper.dart';
import 'package:smart_microbus/core/helpers/spacing.dart';
import 'package:smart_microbus/core/routing/routes.dart';
import 'package:smart_microbus/core/widgets/custom_text_field.dart';
import 'package:smart_microbus/features/Auth/login/domain/entites/reset_password_entity.dart';
import 'package:smart_microbus/features/Auth/login/presentation/cubit/cubit/login_cubit.dart';
import 'package:smart_microbus/l10n/app_localizations.dart';

import '../../../../../core/helpers/app_regex.dart';

class ResetPasswordForm extends StatelessWidget {
  const ResetPasswordForm({
    super.key,
    required this.formKey,
    required this.theme,
    required this.loc,
    required this.passController,
    required this.confirmController,
    required this.token,
    required this.userId,
  });

  final GlobalKey<FormState> formKey;
  final ThemeData theme;
  final AppLocalizations loc;
  final TextEditingController passController;
  final TextEditingController confirmController;
  final String token;
  final String userId;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 85,
            width: 85,
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withOpacity(.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.lock_outline_rounded,
              size: 45,
              color: theme.colorScheme.primary,
            ),
          ),

          verticalSpace( 25),

          /// title
          Text(
            loc.resetPassword,
            textAlign: TextAlign.center,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),

          verticalSpace(6),
          Text(
            loc.enterNewPasswordDesc,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: Colors.grey[600],
            ),
          ),

          verticalSpace(35),
          CustomTextField(
            labelText: loc.newPassword,
            hintText: "********",
            controller: passController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return loc.passwordRequired;
              }
              if (!AppRegex.isPasswordValid(value)) {
                return loc.invalidPassword;
              }
              return null;
            },
            isPasswordField: true,
          ),

          verticalSpace(8),
          CustomTextField(
            labelText: loc.confirmPassword,
            hintText: "********",
            controller: confirmController,
            validator: (v) {
              if (v != passController.text) {
                return loc.passwordNotMatch;
              }
              return null;
            },
            isPasswordField: true,
          ),

          verticalSpace(35),

          BlocListener<LoginCubit, LoginState>(
            listener: (context, state) {
              if (state is ResetPasswordLoading) {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (_) =>
                      const Center(child: CircularProgressIndicator()),
                );
              }

              if (state is ResetPasswordFailure) {
                if (Navigator.of(context).canPop()) {
                  context.pop();
                }
                showGlobalSnackBar(state.message);
                ShowToastHelper.showToast(
                  context,
                  state.message,
                  backgroundColor: Colors.redAccent,
                  icon: Icons.close,
                );
              }

              if (state is ResetPasswordSuccess) {
                if (Navigator.of(context).canPop()) {
                  context.pop();
                }
                ShowToastHelper.showToast(context, loc.passwordResetSuccess);
                confirmController.clear();
                passController.clear();
                context.pushNamedAndRemoveUntilRoot(Routes.login);
              }
            },

            child: SizedBox(
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    context.read<LoginCubit>().resetPassword(
                      entity: ResetPasswordEntity(
                        userId: userId,
                        token: token,
                        newPassword: passController.text,
                        confirmPassword: confirmController.text,
                      ),
                    );
                  }
                },
                child: Text(
                  loc.resetPassword,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
