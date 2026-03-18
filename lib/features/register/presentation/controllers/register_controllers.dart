import 'package:flutter/material.dart';

class RegisterControllers {
  final fullNameController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final licenseNumberController = TextEditingController();

  RegisterUserType userType = RegisterUserType.passenger;

  final formKey = GlobalKey<FormState>();

  void dispose() {
    fullNameController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    licenseNumberController.dispose();
  }
}

enum RegisterUserType { passenger, driver }
