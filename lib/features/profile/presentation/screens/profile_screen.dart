import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:smart_microbus/core/helpers/app_error_helper.dart';

import 'package:smart_microbus/features/profile/presentation/widgets/profile_listener.dart';
import 'package:smart_microbus/features/profile/presentation/widgets/section_card.dart';
import 'package:smart_microbus/l10n/app_localizations.dart';

import '../../../../core/auth/session_manager.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/localization/locale_cubit.dart';

import '../../../../core/localization/locale_state.dart';
import '../../../../core/theme/theme_cubit.dart';
import '../../../passener/presentation/widgets/guest_widgets/guest_profile_widget.dart';
import '../cubit/profile_cubit.dart';

import '../cubit/profile_state.dart';
import '../widgets/confirm_dialog.dart';
import '../widgets/menu_tile.dart';
import '../widgets/menu_switch_tile.dart';
import '../widgets/profile_header.dart';
import '../widgets/section_title.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();

    if (!SessionManager.isGuest) {
      context.read<ProfileCubit>().loadProfile();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (SessionManager.isGuest) {
      return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,

        body: const GuestProfileWidget(),
      );
    }
    final primary = Theme.of(context).colorScheme.primary;
    final tr = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: ProfileListener(
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<ProfileCubit, ProfileState>(
                buildWhen: (previous, current) {
                  if (current is ProfilePhotoUploading) return false;
                  return true;
                },
                builder: (context, state) {
                  if (state is ProfileLoading ||
                      state is LogoutLoading ||
                      state is ProfileDeleteAccountLoading ||
                      state is ProfilePhotoDeletLoading) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (state is ProfileError) {
                    return AppErrorWidget(
                      message: state.message,
                      onRetry: () => context.read<ProfileCubit>().loadProfile(),
                    );
                  }

                  if (state is LogoutError) {
                    return AppErrorWidget(
                      message: state.message,
                      onRetry: () => context.read<ProfileCubit>().logout(),
                    );
                  }
                  if (state is ProfileDeleteAccountError) {
                    return AppErrorWidget(
                      message: state.message,
                      onRetry: () =>
                          context.read<ProfileCubit>().deleteAccount(),
                    );
                  }
                  if (state is ProfileLoaded) {
                    final user = state.profile;

                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          ProfileHeader(profile: user),
                          SectionTitle(tr.accountInformation),
                          SectionCard(
                            children: [
                              _infoTile(Icons.phone, user.phone, primary),
                              _infoTile(
                                Icons.verified_user_outlined,
                                user.isActive == true ? tr.active : tr.inactive,
                                primary,
                              ),
                            ],
                          ),

                          verticalSpace(15),
                          SectionTitle(tr.actions),
                          SectionCard(
                            children: [
                              /// Dark Mode
                              BlocBuilder<ThemeCubit, ThemeMode>(
                                builder: (context, themeMode) {
                                  return MenuSwitchTile(
                                    icon: Icons.dark_mode_outlined,
                                    title: tr.darkMode,
                                    value: themeMode == ThemeMode.dark,
                                    onChanged: (_) {
                                      context.read<ThemeCubit>().toggleTheme();
                                    },
                                  );
                                },
                              ),

                              /// English
                              BlocBuilder<LocaleCubit, LocaleState>(
                                builder: (context, localeState) {
                                  return MenuSwitchTile(
                                    icon: Icons.language,
                                    title: tr.english,
                                    value:
                                        localeState.locale.languageCode == 'en',
                                    onChanged: (_) {
                                      context
                                          .read<LocaleCubit>()
                                          .toggleLocale();
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                          verticalSpace(15),
                          SectionTitle(tr.more),

                          SectionCard(
                            children: [
                              _logoutButton(tr, context),
                              _deleteAccountButton(tr, context),
                            ],
                          ),

                          verticalSpace(30),
                        ],
                      ),
                    );
                  }

                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _logoutButton(AppLocalizations tr, BuildContext context) {
    return MenuTile(Icons.logout, () {
      context.read<ProfileCubit>().logout();
    }, tr.logout);
  }

  Widget _deleteAccountButton(AppLocalizations tr, BuildContext context) {
    return MenuTile(
      Icons.delete_outline,
      () {
        showDialog(
          context: context,
          builder: (_) => ConfirmDeleteDialog(
            onConfirm: () {
              context.read<ProfileCubit>().deleteAccount();
            },
          ),
        );
      },
      tr.deleteAccount,
      isDanger: true,
    );
  }

  Widget _infoTile(IconData icon, String title, Color? primary) {
    return ListTile(
      leading: Icon(icon, color: primary),
      title: Text(title, maxLines: 1, overflow: TextOverflow.ellipsis),
    );
  }
}
