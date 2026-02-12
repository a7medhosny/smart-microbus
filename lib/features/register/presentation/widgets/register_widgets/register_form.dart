// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:smart_microbus/l10n/app_localizations.dart';

import '../../../../../../core/widgets/custom_text_field.dart';
import '../../controllers/register_controllers.dart';

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

    return Form(
      key: widget.controllers.formKey,
      child: Column(
        children: [
          // ================= USER TYPE =================
          Row(
            children: [
              Expanded(
                child: RadioListTile<RegisterUserType>(
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
              Expanded(
                child: RadioListTile<RegisterUserType>(
                  title: Text(loc.driver),
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
              if (value == null || value.length < 6) {
                return loc.password;
              }
              return null;
            },
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
                  return loc.enterLicenseNumber;
                }
                return null;
              },
            ),
        ],
      ),
    );
  }
}
