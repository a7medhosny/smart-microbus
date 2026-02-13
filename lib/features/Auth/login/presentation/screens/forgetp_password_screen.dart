import 'package:flutter/material.dart';
import 'package:smart_microbus/features/Auth/login/presentation/widgets/forget_password_form.dart';
import 'package:smart_microbus/l10n/app_localizations.dart';

class ForgetpPasswordScreen extends StatelessWidget {
  const ForgetpPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final passwordController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(15),
                      blurRadius: 30,
                      offset: const Offset(0, 15),
                    ),
                  ],
                ),
                child: ForgetPasswordForm(
                  phoneController: passwordController,
                  formKey: formKey,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
