import 'package:flutter/material.dart';
import 'package:smart_microbus/features/Auth/login/presentation/widgets/forget_password_form.dart';

class ForgetpPasswordScreen extends StatelessWidget {
  const ForgetpPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final passwordController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(10),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
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
