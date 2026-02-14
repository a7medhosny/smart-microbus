import 'package:flutter/material.dart';

import '../controllers/register_controllers.dart';
import '../widgets/register_widgets/register_button.dart';
import '../widgets/register_widgets/register_footer.dart';
import '../widgets/register_widgets/register_form.dart';
import '../widgets/register_widgets/register_header.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final controllers = RegisterControllers();

  @override
  void dispose() {
    controllers.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              const RegisterHeader(),

              const SizedBox(height: 24),

              RegisterForm(controllers: controllers),

              const SizedBox(height: 16),

              const RegisterFooter(),
            ],
          ),
        ),
      ),
    );
  }
}
