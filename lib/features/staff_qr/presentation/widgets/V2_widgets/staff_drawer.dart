import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/auth/token_manager.dart';
import '../../../../../core/helpers/extensions.dart';
import '../../../../../core/localization/locale_cubit.dart';
import '../../../../../core/networking/dio_factory.dart';
import '../../../../../core/routing/routes.dart';
import '../../../../../core/theme/theme_cubit.dart';
import '../../../../../l10n/app_localizations.dart';

class StaffDrawer extends StatelessWidget {
  const StaffDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tr = AppLocalizations.of(context)!;

    final userName = TokenManager.userName ?? "Staff";
    final phone = TokenManager.phone ?? "";

    return Drawer(
      backgroundColor: theme.colorScheme.surface,
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 28),

            // Avatar
            Container(
              height: 88,
              width: 88,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: theme.colorScheme.inverseSurface,
                border: Border.all(
                  color: theme.colorScheme.outline.withOpacity(.08),
                  width: 1.5,
                ),
              ),
              child: Icon(
                Icons.person_rounded,
                size: 44,
                color: theme.colorScheme.primary,
              ),
            ),

            const SizedBox(height: 16),

            Text(
              userName,
              textAlign: TextAlign.center,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),

            if (phone.isNotEmpty) ...[
              const SizedBox(height: 6),

              Text(
                phone,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],

            const SizedBox(height: 24),

            Divider(
              indent: 24,
              endIndent: 24,
              color: theme.colorScheme.outline.withOpacity(.12),
            ),

            const SizedBox(height: 12),

            _DrawerTile(
              icon: Icons.dark_mode_rounded,
              title: tr.changeTheme,
              onTap: () {
                context.read<ThemeCubit>().toggleTheme();
                Navigator.pop(context);
              },
            ),

            _DrawerTile(
              icon: Icons.language_rounded,
              title: tr.changeLanguage,
              onTap: () {
                context.read<LocaleCubit>().toggleLocale();
                Navigator.pop(context);
              },
            ),

            const Spacer(),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Divider(color: theme.colorScheme.outline.withOpacity(.12)),
            ),

            _DrawerTile(
              icon: Icons.logout_rounded,
              title: tr.logout,
              iconColor: theme.colorScheme.error,
              textColor: theme.colorScheme.error,
              showTrailing: false,
              onTap: () {
                TokenManager.clearLoginData();

                DioFactory.removeAuthInterceptor();

                context.pushNamedAndRemoveUntil(Routes.login);
              },
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class _DrawerTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Color? iconColor;
  final Color? textColor;
  final bool showTrailing;

  const _DrawerTile({
    required this.icon,
    required this.title,
    required this.onTap,
    this.iconColor,
    this.textColor,
    this.showTrailing = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
      child: Material(
        color: theme.colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(18),
        child: ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          leading: Icon(icon, color: iconColor),
          title: Text(
            title,
            style: theme.textTheme.titleSmall?.copyWith(
              color: textColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          trailing: showTrailing
              ? Icon(
                  Icons.chevron_right_rounded,
                  color: theme.colorScheme.onSurfaceVariant,
                )
              : null,
          onTap: onTap,
        ),
      ),
    );
  }
}
