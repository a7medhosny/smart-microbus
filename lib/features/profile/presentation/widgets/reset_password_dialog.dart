import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/helpers/app_regex.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../l10n/app_localizations.dart';
import '../cubit/profile_cubit.dart';

void showResetPasswordDialog(BuildContext context) {
  final passController = TextEditingController();
  final confirmController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final loc = AppLocalizations.of(context)!;
  final theme = Theme.of(context);

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(22),
            child: Container(
              decoration: BoxDecoration(
                color: theme.cardColor,
                borderRadius: BorderRadius.circular(22),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  /// 🔹 Title
                  Text(loc.resetPassword, style: theme.textTheme.titleLarge),

                  const SizedBox(height: 20),

                  /// 🔹 الفورم بنفس الكومبوننت
                  ChangePasswordForm(
                    formKey: formKey,
                    theme: theme,
                    loc: loc,
                    newPassController: passController,
                    confirmPassController: confirmController,
                  ),

                  const SizedBox(height: 20),

                  /// 🔹 Buttons
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(loc.cancel),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              context.read<ProfileCubit>().resetPassword(
                                newPassword: passController.text,
                                confirmPassword: confirmController.text,
                              );
                              Navigator.pop(context);
                            }
                          },
                          child: Text(loc.confirm),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

class ChangePasswordForm extends StatelessWidget {
  const ChangePasswordForm({
    super.key,
    required this.formKey,
    required this.theme,
    required this.loc,
    required this.newPassController,
    required this.confirmPassController,
  });

  final GlobalKey<FormState> formKey;
  final ThemeData theme;
  final AppLocalizations loc;
  final TextEditingController newPassController;
  final TextEditingController confirmPassController;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          /// 🔹 Icon
          Center(
            child: Container(
              height: 85,
              width: 85,
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withOpacity(.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.lock_reset_rounded,
                size: 45,
                color: theme.colorScheme.primary,
              ),
            ),
          ),

          const SizedBox(height: 25),

          /// 🔹 Title
          Text(
            loc.changePassword,
            textAlign: TextAlign.center,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 6),

          /// 🔹 Description
          Text(
            loc.changePasswordDesc,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),

          const SizedBox(height: 35),

          /// 🔹 New Password
          CustomTextField(
            labelText: loc.newPassword,
            hintText: "********",
            controller: newPassController,
            isPasswordField: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return loc.passwordRequired;
              }
              if (!AppRegex.isPasswordValid(value)) {
                return loc.invalidPassword;
              }
              return null;
            },
          ),

          const SizedBox(height: 10),

          /// 🔹 Confirm Password
          CustomTextField(
            labelText: loc.confirmPassword, // لازم تضيفها لو مش موجودة
            hintText: "********",
            controller: confirmPassController,
            isPasswordField: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return loc.passwordRequired;
              }
              if (value != newPassController.text) {
                return loc.passwordNotMatch;
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
