import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_microbus/core/auth/token_manager.dart';

import '../../../../core/localization/locale_cubit.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theme/theme_cubit.dart';
import '../../../../l10n/app_localizations.dart';
import '../cubit/profile_cubit.dart';
import '../cubit/profile_state.dart';
import '../widgets/profile_header.dart';
import '../widgets/profile_tile.dart';
import '../widgets/reset_password_dialog.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    context.read<ProfileCubit>().loadProfile();
    super.initState();
  }

  @override
@override
Widget build(BuildContext context) {
  final tr = AppLocalizations.of(context)!;
  final theme = Theme.of(context);

  return Scaffold(
    appBar: AppBar(
      title: Text(tr.profile),
      centerTitle: true,
    ),

    body: BlocListener<ProfileCubit, ProfileState>(
      listener: (context, state) {
        /// Reset Password
        if (state is ResetPasswordSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(tr.passwordUpdated)),
          );
        }

        if (state is ResetPasswordError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }

        /// Logout
        if (state is LogoutSuccess) {
          TokenManager.clearLoginData();
          Navigator.pushNamedAndRemoveUntil(
            context,
            Routes.login,
            (route) => false,
          );
        }

        if (state is LogoutError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },

      child: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          /// Loading
          if (state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          /// Error
          if (state is ProfileError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 60,
                    color: theme.colorScheme.error,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    state.message,
                    style: theme.textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),

                  ElevatedButton.icon(
                    onPressed: () {
                      context.read<ProfileCubit>().loadProfile();
                    },
                    icon: const Icon(Icons.refresh),
                    label: Text(tr.retry),
                  ),
                ],
              ),
            );
          }

          /// Success
          if (state is ProfileLoaded) {
            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                ProfileHeader(profile: state.profile),

                const SizedBox(height: 24),

                Text(
                  tr.settings,
                  style: theme.textTheme.titleMedium,
                ),

                const SizedBox(height: 12),

                // ProfileTile(
                //   icon: Icons.lock,
                //   title: tr.resetPassword,
                //   onTap: () => showResetPasswordDialog(context),
                // ),

                ProfileTile(
                  icon: Icons.language,
                  title: tr.changeLanguage,
                  onTap: context.read<LocaleCubit>().toggleLocale,
                ),

                ProfileTile(
                  icon: Icons.dark_mode,
                  title: tr.changeTheme,
                  onTap: context.read<ThemeCubit>().toggleTheme,
                ),

                const SizedBox(height: 20),

                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(14),
                    backgroundColor: theme.colorScheme.error,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: () {
                    context.read<ProfileCubit>().logout();
                  },
                  icon: const Icon(Icons.logout),
                  label: Text(tr.logout),
                ),
              ],
            );
          }

          return const SizedBox();
        },
      ),
    ),
  );
}
}
