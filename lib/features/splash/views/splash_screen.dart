import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:smart_microbus/core/auth/session_manager.dart';
import 'package:smart_microbus/core/auth/token_manager.dart';
import 'package:smart_microbus/core/routing/routes.dart';
import 'package:smart_microbus/core/theme/app_colors.dart';
import 'package:smart_microbus/features/splash/widgets/typing_text.dart';
import 'package:smart_microbus/l10n/app_localizations.dart';

import '../../../core/storage/cache_helper.dart';
import '../../../core/storage/cache_keys.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController logoController;

  @override
  void initState() {
    super.initState();

    logoController = AnimationController(
      vsync: this,

      duration: const Duration(seconds: 2),

      lowerBound: .95,

      upperBound: 1.05,
    )..repeat(reverse: true);

    Future.delayed(const Duration(seconds: 6), startApp);
  }

  @override
  void dispose() {
    logoController.dispose();

    super.dispose();
  }

  Future<void> startApp() async {
    final session = await SessionManager.initializeSession();

    final isDriver = TokenManager.role == 'Driver';
    final bool isOnboardingCompleted =
        CacheHelper.getCacheData(key: CacheKeys.onboardingKey) == 'true';

    if (!mounted) return;

    switch (session) {
      case SessionState.guest:
        Navigator.pushReplacementNamed(
          context,

          Routes.passengerNavigationScreen,
        );

        break;

      case SessionState.authenticated:
        Navigator.pushReplacementNamed(
          context,

          isDriver
              ? Routes.driverNavigationScreen
              : Routes.passengerNavigationScreen,
        );

        break;

      case SessionState.unauthenticated:
        isOnboardingCompleted
            ? Navigator.pushReplacementNamed(context, Routes.homeScreen)
            : Navigator.pushReplacementNamed(context, Routes.onboarding);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final tr = AppLocalizations.of(context)!;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,

            end: Alignment.bottomRight,

            colors: isDark
                ? [
                    const Color(0xff081120),

                    const Color(0xff102A43),

                    AppColorsDark.primary,

                    const Color(0xff00C2A8),
                  ]
                : [
                    const Color(0xffF8FBFF),

                    const Color(0xffE8F4FF),

                    const Color(0xffE6FFF7),

                    const Color(0xffD9F7FF),
                  ],
          ),
        ),

        child: Stack(
          children: [
            ...List.generate(18, (index) {
              return Positioned(
                top: 80.0 * (index % 8),

                left: 50.0 * (index % 6),

                child: Container(
                  width: 5,

                  height: 5,

                  decoration: BoxDecoration(
                    shape: BoxShape.circle,

                    color: AppColorsLight.primary.withOpacity(.12),
                  ),
                ),
              );
            }),

            Positioned(
              top: -120,

              right: -70,

              child: glow(250, AppColorsLight.primary.withOpacity(.15)),
            ),

            Positioned(
              bottom: -100,

              left: -60,

              child: glow(300, AppColorsLight.secondary.withOpacity(.18)),
            ),

            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  AnimatedBuilder(
                    animation: logoController,

                    builder: (_, child) {
                      return Transform.scale(
                        scale: logoController.value,

                        child: child,
                      );
                    },

                    child: Container(
                      padding: const EdgeInsets.all(20),

                      decoration: BoxDecoration(
                        shape: BoxShape.circle,

                        color: Colors.white.withOpacity(.2),

                        boxShadow: [
                          BoxShadow(
                            color: AppColorsLight.primary.withOpacity(.2),

                            blurRadius: 35,
                          ),
                        ],
                      ),

                      child: Image.asset(
                        "assets/images/waslaLogo.png",

                        width: 120,
                      ),
                    ),
                  ),

                  const SizedBox(height: 35),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      Icon(
                        Icons.location_on_rounded,

                        size: 36,

                        color: isDark ? Colors.white : AppColorsLight.primary,
                      ),

                      const SizedBox(width: 8),

                      TypingText(isDark: isDark),
                    ],
                  ),

                  const SizedBox(height: 12),

                  Container(
                    width: 90,

                    height: 4,

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),

                      gradient: LinearGradient(
                        colors: [
                          AppColorsLight.primary,

                          AppColorsLight.secondary,
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 18),

                  Text(
                    tr.smart_transport_platform,

                    style: GoogleFonts.sora(
                      fontSize: 14,

                      letterSpacing: 2,

                      fontWeight: FontWeight.w500,

                      color: isDark ? Colors.white70 : Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget glow(double size, Color color) {
    return Container(
      width: size,

      height: size,

      decoration: BoxDecoration(
        shape: BoxShape.circle,

        gradient: RadialGradient(colors: [color, Colors.transparent]),
      ),
    );
  }
}
