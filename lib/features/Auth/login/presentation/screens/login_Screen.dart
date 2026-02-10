import 'package:flutter/material.dart';
import 'package:smart_microbus/core/helpers/spacing.dart';
import 'package:smart_microbus/features/Auth/login/presentation/widgets/login_footer.dart';
import 'package:smart_microbus/features/Auth/login/presentation/widgets/login_form_body.dart';
import 'package:smart_microbus/features/Auth/login/presentation/widgets/login_header.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              LoginHeader(),
              verticalSpace(30),
              LoginFormBody(
                formKey: formKey,
                phoneController: phoneController,
                passwordController: passwordController,
              ),
              verticalSpace(20),
              LoginFooter(),
            ],
          ),
        ),
      ),
    );
  }
}
