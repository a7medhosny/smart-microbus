import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/helpers/extensions.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/localization/locale_cubit.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theme/theme_cubit.dart';
import '../../../../l10n/app_localizations.dart';
import '../../login/presentation/cubit/cubit/login_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localeCubit = context.read<LocaleCubit>();

    final themeCubit = context.read<ThemeCubit>();

    final tr = AppLocalizations.of(context)!;

    final theme = Theme.of(context);

    final isDark = theme.brightness == Brightness.dark;

    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginGuestSuccess) {
          context.pushNamedRoot(Routes.passengerNavigationScreen);
        }
      },

      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,

        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                /// HEADER
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: tr.appName[0],

                            style: GoogleFonts.spaceGrotesk(
                              fontSize: 30,

                              fontWeight: FontWeight.w900,

                              foreground: Paint()
                                ..shader =
                                    LinearGradient(
                                      begin: Alignment.topCenter,

                                      end: Alignment.bottomCenter,
                                      colors: [
                                        theme.colorScheme.primary,

                                        theme.colorScheme.secondary,
                                      ],
                                    ).createShader(
                                      const Rect.fromLTWH(0, 0, 40, 70),
                                    ),
                            ),
                          ),

                          TextSpan(
                            text: tr.appName.substring(1),

                            style: GoogleFonts.spaceGrotesk(
                              fontSize: 28,

                              fontWeight: FontWeight.w800,

                              letterSpacing: -1.5,

                              color: theme.colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: theme.cardColor,

                        borderRadius: BorderRadius.circular(18),

                        border: Border.all(color: theme.dividerColor),
                      ),

                      child: IconButton(
                        onPressed: themeCubit.toggleTheme,

                        icon: Icon(
                          isDark
                              ? Icons.light_mode_rounded
                              : Icons.dark_mode_rounded,

                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ),
                  ],
                ),

                verticalSpace(42),

                /// HERO ICON
                Center(
                  child: Container(
                    width: 120,

                    height: 120,

                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,

                        end: Alignment.bottomRight,

                        colors: [
                          theme.colorScheme.primary,

                          theme.colorScheme.secondary,
                        ],
                      ),

                      borderRadius: BorderRadius.circular(34),

                      boxShadow: [
                        BoxShadow(
                          color: theme.colorScheme.primary.withOpacity(.18),

                          blurRadius: 25,

                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),

                    child: const Icon(
                      Icons.route_rounded,

                      color: Colors.white,

                      size: 52,
                    ),
                  ),
                ),

                verticalSpace(35),

                /// TITLE
                Center(
                  child: Text(
                    tr.welcomeToWasla,

                    textAlign: TextAlign.center,

                    style: GoogleFonts.sora(
                      fontSize: 24,

                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                verticalSpace(10),

                /// DESCRIPTION
                Container(
                  width: double.infinity,

                  padding: const EdgeInsets.all(15),

                  decoration: BoxDecoration(
                    color: theme.cardColor,

                    borderRadius: BorderRadius.circular(24),

                    border: Border.all(color: theme.dividerColor),
                  ),

                  child: Text(
                    tr.chooseRoleDescription,

                    textAlign: TextAlign.center,

                    style: GoogleFonts.manrope(
                      fontSize: 15,

                      height: 1.8,

                      color: theme.textTheme.bodyMedium?.color?.withOpacity(
                        .72,
                      ),
                    ),
                  ),
                ),

                verticalSpace(30),

                /// LOGIN
                _button(
                  context,

                  icon: Icons.login_rounded,

                  text: tr.login,

                  filled: true,

                  onTap: () {
                    context.pushNamedRoot(Routes.login);
                  },
                ),

                verticalSpace(14),

                /// REGISTER
                _button(
                  context,

                  icon: Icons.person_add_alt_1,

                  text: tr.register,

                  onTap: () {
                    context.pushNamedRoot(Routes.register);
                  },
                ),

                verticalSpace(14),

                /// GUEST
                _button(
                  context,

                  icon: Icons.explore_outlined,

                  text: tr.continue_as_guest,

                  onTap: () {
                    context.read<LoginCubit>().continueAsGuest();
                  },
                ),

                verticalSpace(38),

                /// LANGUAGE
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(4),

                    decoration: BoxDecoration(
                      color: theme.cardColor,

                      borderRadius: BorderRadius.circular(18),

                      border: Border.all(color: theme.dividerColor),
                    ),

                    child: Row(
                      mainAxisSize: MainAxisSize.min,

                      children: [
                        _langButton("EN", localeCubit.toEnglish),

                        Container(
                          width: 1,

                          height: 20,

                          color: theme.dividerColor,
                        ),

                        _langButton("AR", localeCubit.toArabic),
                      ],
                    ),
                  ),
                ),

                verticalSpace(18),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _langButton(String text, VoidCallback onTap) {
    return TextButton(onPressed: onTap, child: Text(text));
  }

  Widget _button(
    BuildContext context, {

    required String text,

    required IconData icon,

    required VoidCallback onTap,

    bool filled = false,
  }) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,

      borderRadius: BorderRadius.circular(22),

      child: Container(
        height: 62,

        padding: const EdgeInsets.symmetric(horizontal: 22),

        decoration: BoxDecoration(
          color: filled ? theme.colorScheme.primary : theme.cardColor,

          borderRadius: BorderRadius.circular(22),

          border: Border.all(
            color: filled ? Colors.transparent : theme.dividerColor,
          ),

          boxShadow: filled
              ? [
                  BoxShadow(
                    color: theme.colorScheme.primary.withOpacity(.18),

                    blurRadius: 16,

                    offset: const Offset(0, 6),
                  ),
                ]
              : [],
        ),

        child: Row(
          children: [
            Icon(
              icon,

              color: filled ? Colors.white : theme.colorScheme.primary,
            ),

            horizontalSpace(16),

            Expanded(
              child: Text(
                text,

                style: GoogleFonts.manrope(
                  fontSize: 16,

                  fontWeight: FontWeight.w700,

                  color: filled ? Colors.white : null,
                ),
              ),
            ),

            Icon(
              Icons.arrow_forward_ios_rounded,

              size: 16,

              color: filled
                  ? Colors.white70
                  : theme.textTheme.bodyMedium?.color?.withOpacity(.5),
            ),
          ],
        ),
      ),
    );
  }
}
