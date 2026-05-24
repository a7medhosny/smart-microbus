import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_microbus/core/theme/app_colors.dart';

import '../../../l10n/app_localizations.dart';

class TypingText extends StatelessWidget {
  final bool isDark;

  const TypingText({super.key, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context)!;
    return AnimatedTextKit(
      totalRepeatCount: 1,

      animatedTexts: [
        TypewriterAnimatedText(
          tr.appName,

          speed: const Duration(milliseconds: 300),

          cursor: "|",

          textStyle: GoogleFonts.sora(
            fontSize: 46,

            fontWeight: FontWeight.w800,

            letterSpacing: 3,

            color: isDark ? Colors.white : AppColorsLight.primary,

            shadows: [
              Shadow(
                blurRadius: 30,

                color: AppColorsLight.primary.withOpacity(.3),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
