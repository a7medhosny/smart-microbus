import 'package:flutter/material.dart';

import 'primary_button.dart';

class OnboardingNextButton extends StatelessWidget {
  final VoidCallback onTap;
  final String title;

  const OnboardingNextButton({
    super.key,
    required this.onTap,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      title: title,
      onTap: onTap,
    );
  }
}