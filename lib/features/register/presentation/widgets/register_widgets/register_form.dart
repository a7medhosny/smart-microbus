// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:smart_microbus/core/helpers/spacing.dart';
import 'package:smart_microbus/l10n/app_localizations.dart';

import '../../../../../../core/widgets/custom_text_field.dart';
import '../../../../../core/helpers/app_regex.dart';
import '../../controllers/register_controllers.dart';
import 'register_button.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key, required this.controllers});

  final RegisterControllers controllers;

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Container(
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
      child: Form(
        key: widget.controllers.formKey,
        child: Column(
          children: [
            // ================= USER TYPE =================
            Row(
              children: [
                Expanded(
                  child: RadioListTile<RegisterUserType>(
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                    visualDensity: const VisualDensity(
                      horizontal: -4,
                      vertical: -4,
                    ),
                    title: Text(loc.passenger),
                    value: RegisterUserType.passenger,
                    groupValue: widget.controllers.userType,
                    onChanged: (value) {
                      setState(() {
                        widget.controllers.userType = value!;
                      });
                    },
                  ),
                ),
                horizontalSpace(30),
                Expanded(
                  child: RadioListTile<RegisterUserType>(
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                    visualDensity: const VisualDensity(
                      horizontal: -4,
                      vertical: -4,
                    ),

                    title: Text(
                      loc.driver,

                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),

                    value: RegisterUserType.driver,
                    groupValue: widget.controllers.userType,
                    onChanged: (value) {
                      setState(() {
                        widget.controllers.userType = value!;
                      });
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // ================= NAME =================
            CustomTextField(
              labelText: loc.fullName,
              hintText: loc.enterFullName,
              controller: widget.controllers.fullNameController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return loc.enterFullName;
                }
                return null;
              },
            ),

            const SizedBox(height: 16),

            // ================= PHONE =================
            CustomTextField(
              labelText: loc.phoneNumber,
              hintText: loc.enterPhoneNumber,
              controller: widget.controllers.phoneController,
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return loc.enterPhoneNumber;
                }
                if (!AppRegex.isPhoneNumberValid(value)) {
                  return loc.invalidPhone;
                }
                return null;
              },
            ),

            const SizedBox(height: 16),

            // ================= PASSWORD =================
            CustomTextField(
              labelText: loc.password,
              hintText: "********",
              controller: widget.controllers.passwordController,
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

            const SizedBox(height: 16),

            // ================= LICENSE (Driver Only) =================
            if (widget.controllers.userType == RegisterUserType.driver)
              CustomTextField(
                labelText: loc.licenseNumber,
                hintText: loc.enterLicenseNumber,

                controller: widget.controllers.licenseNumberController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return loc.licenseRequired;
                  }
                  if (!AppRegex.isDrivingLicenseValid(value)) {
                    return loc.invalidLicense;
                  }
                  return null;
                },
              ),
            const SizedBox(height: 24),

            RegisterButton(controllers: widget.controllers),
          ],
        ),
      ),
    );
  }
}
