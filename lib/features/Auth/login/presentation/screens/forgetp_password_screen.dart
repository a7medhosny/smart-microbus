import 'package:flutter/material.dart';
import 'package:smart_microbus/features/Auth/login/presentation/widgets/forget_password_form.dart';

class ForgetpPasswordScreen extends StatelessWidget {
  const ForgetpPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final passwordController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      body: ForgetPasswordForm(
        controller: passwordController,
        formKey: formKey,
      ),
    );
  }
}
