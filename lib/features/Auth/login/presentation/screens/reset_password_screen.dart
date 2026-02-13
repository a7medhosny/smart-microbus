import 'package:flutter/material.dart';

import 'package:smart_microbus/features/Auth/login/presentation/widgets/reset_password_form.dart';
import 'package:smart_microbus/l10n/app_localizations.dart';

class ResetPasswordScreen extends StatelessWidget {
  final String phone;
  final String token;
  final String userId;

  const ResetPasswordScreen({
    super.key,
    required this.phone,
    required this.token,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    final passController = TextEditingController();
    final confirmController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    final loc = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.resetPassword),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: theme.cardColor,
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(15),
                      blurRadius: 25,
                      offset: const Offset(0, 12),
                    ),
                  ],
                ),
                child: ResetPasswordForm(
                  formKey: formKey,
                  theme: theme,
                  loc: loc,
                  passController: passController,
                  confirmController: confirmController,
                  token: token,
                  userId: userId,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
