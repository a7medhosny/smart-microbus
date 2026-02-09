import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/theme_cubit.dart';
import '../controllers/register_controllers.dart';
import '../widgets/register_button.dart';
import '../widgets/register_footer.dart';
import '../widgets/register_form.dart';
import '../widgets/register_header.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() =>
      _RegisterScreenState();
}

class _RegisterScreenState
    extends State<RegisterScreen> {
  final controllers =
      RegisterControllers();

  @override
  void dispose() {
    controllers.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(
              Icons.dark_mode,
            ),
            onPressed: () {
              context
                  .read<ThemeCubit>()
                  .toggleTheme();
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding:
              const EdgeInsets.all(16),
          child: Column(
            children: [
              const RegisterHeader(),

              const SizedBox(height: 24),

              RegisterForm(
                controllers:
                    controllers,
              ),

              const SizedBox(height: 24),

              RegisterButton(
                controllers:
                    controllers,
              ),

              const SizedBox(height: 16),

              const RegisterFooter(),
            ],
          ),
        ),
      ),
    );
  }
}
