import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lottie/lottie.dart';

import '../../domain/entities/onboarding_entity.dart';
import 'animated_text_section.dart';
import 'glass_card.dart';

class OnboardingPageViewItem extends StatelessWidget {
  final OnboardingEntity item;
  final String title;
  final String subtitle;

  const OnboardingPageViewItem({
    super.key,
    required this.item,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const Spacer(),
          GlassCard(
            child: SizedBox(
              height: size.height * .32,
              child: Lottie.asset(
                item.animation,
                fit: BoxFit.contain,
              ),
            ),
          )
              .animate()
              .scale(duration: 500.ms)
              .fade(),
          const SizedBox(height: 40),
          AnimatedTextSection(
            title: title,
            subtitle: subtitle,
          ),
          const Spacer(),
        ],
      ),
    );
  }
}