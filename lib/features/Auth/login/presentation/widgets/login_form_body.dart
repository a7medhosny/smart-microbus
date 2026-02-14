import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_microbus/core/auth/token_helper.dart';
import 'package:smart_microbus/core/auth/token_manager.dart';
import 'package:smart_microbus/core/helpers/app_snack_bar.dart';
import 'package:smart_microbus/core/helpers/extensions.dart';
import 'package:smart_microbus/core/helpers/show_toast_helper.dart';
import 'package:smart_microbus/core/helpers/spacing.dart';
import 'package:smart_microbus/core/storage/cache_keys.dart';
import 'package:smart_microbus/core/widgets/custom_text_field.dart';
import 'package:smart_microbus/features/Auth/login/domain/entites/login_entity.dart';
import 'package:smart_microbus/features/Auth/login/presentation/cubit/cubit/login_cubit.dart';
import 'package:smart_microbus/l10n/app_localizations.dart';

import '../../../../../core/helpers/app_regex.dart';
import '../../../../../core/routing/routes.dart';

class LoginFormBody extends StatefulWidget {
  const LoginFormBody({
    super.key,
    required this.formKey,
    required this.phoneController,
    required this.passwordController,
  });
  final GlobalKey<FormState> formKey;
  final TextEditingController phoneController;
  final TextEditingController passwordController;

  @override
  State<LoginFormBody> createState() => _LoginFormBodyState();
}

class _LoginFormBodyState extends State<LoginFormBody> {
  bool rememberMe = false;
  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Form(
      key: widget.formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomTextField(
            labelText: loc.phoneNumber,
            controller: widget.phoneController,
            keyboardType: TextInputType.phone,

            validator: (value) {
              if (value == null || value.isEmpty) {
                return loc.phoneRequired;
              }
              if (!AppRegex.isPhoneNumberValid(value)) {
                return loc.invalidPhone;
              }
              return null;
            },
            hintText: loc.enterPhoneNumber,
          ),
          verticalSpace(25),
          CustomTextField(
            labelText: loc.password,
            controller: widget.passwordController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return loc.passwordRequired;
              }
              if (!AppRegex.isPasswordValid(value)) {
                return loc.invalidPassword;
              }
              return null;
            },
            hintText: '********',
            isPasswordField: true,
          ),
          verticalSpace(20),
          Row(
            children: [
              Checkbox(
                value: rememberMe,
                onChanged: (value) {
                  setState(() {
                    rememberMe = value ?? false;
                  });
                },
              ),
              Text(loc.rememberMe),
            ],
          ),
          verticalSpace(40),
          BlocConsumer<LoginCubit, LoginState>(
            listener: (context, state) {
              if (state is LoginLoading) {
                showDialog(
                  context: context,
                  builder: (context) =>
                      const Center(child: CircularProgressIndicator()),
                );
              } else if (state is LoginFailure) {
                if (Navigator.of(context).canPop()) {
                  context.pop();
                }
                if (state.message.contains("not confirmed")) {
                  ShowToastHelper.showToast(
                    context,
                    loc.phoneNotConfirmed,
                    backgroundColor: Colors.redAccent,
                    icon: Icons.close,
                  );

                  context.pushNamed(
                    Routes.otpVerification,
                    arguments: {
                      "phone": widget.phoneController.text,
                      "from": CacheKeys.confirmAccount,
                    },
                  );
                } else {
                  // showGlobalSnackBar(state.message);
                  ShowToastHelper.showToast(
                    context,
                    state.message,
                    backgroundColor: Colors.redAccent,
                    icon: Icons.close,
                  );
                }
              } else if (state is LoginSuccess) {
                final user = state.user;
                final String loginSucess =
                    "${TokenHelper.extractRoles(user.token) == "Passenger" ? loc.passenger : loc.driver} ${loc.loginSuccess}";
                if (Navigator.of(context).canPop()) {
                  context.pop();
                }
                ShowToastHelper.showToast(context, loginSucess);
                widget.phoneController.clear();
                widget.passwordController.clear();
                TokenManager.saveLoginData(
                  token: user.token,
                  refreshToken: user.refreshToken,
                  expiration: user.expiration,
                  refreshTokenExpirationDateTime:
                      user.refreshTokenExpirationDateTime,
                  userName: user.userName,
                  phone: user.phone,
                  userId: TokenHelper.extractUserId(user.token) ?? '',
                );
              }
            },
            builder: (context, state) {
              return SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (widget.formKey.currentState!.validate()) {
                      context.read<LoginCubit>().login(
                        entity: LoginEntity(
                          phoneNumber: widget.phoneController.text,
                          password: widget.passwordController.text,
                          rememberMe: false,
                        ),
                      );
                    }
                  },
                  child: Text(loc.login),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
