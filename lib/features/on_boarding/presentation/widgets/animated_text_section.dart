import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AnimatedTextSection extends StatelessWidget {
  final String title;
  final String subtitle;

  const AnimatedTextSection({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        )
            .animate()
            .fade(duration: 500.ms)
            .slideY(begin: .2),
        const SizedBox(height: 14),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: textTheme.bodyLarge?.copyWith(
            height: 1.6,
          ),
        )
            .animate(delay: 200.ms)
            .fade(duration: 600.ms),
      ],
    );
  }
}