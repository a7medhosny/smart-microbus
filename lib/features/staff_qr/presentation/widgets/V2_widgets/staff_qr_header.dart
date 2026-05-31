import 'package:flutter/material.dart';
import 'top_menu_button.dart';

class StaffQrHeader extends StatelessWidget {
  final Color color;
  final AnimationController pulseController;
  final String title;
  final String subtitle;

  const StaffQrHeader({
    super.key,
    required this.color,
    required this.pulseController,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        AnimatedBuilder(
          animation: pulseController,
          builder: (_, child) {
            return Transform.scale(
              scale: 1 + (pulseController.value * .05),
              child: child,
            );
          },
          child: Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              gradient: LinearGradient(
                colors: [
                  color,
                  color.withOpacity(.6),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(.4),
                  blurRadius: 24,
                ),
              ],
            ),
            child: const Icon(
              Icons.qr_code_scanner_rounded,
              color: Colors.white,
              size: 30,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style:
                    theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style:
                    theme.textTheme.bodyMedium?.copyWith(
                  color: theme
                      .colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
        const TopMenuButton(),
      ],
    );
  }
}