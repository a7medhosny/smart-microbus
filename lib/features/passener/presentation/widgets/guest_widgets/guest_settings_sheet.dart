import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/localization/locale_cubit.dart';
import '../../../../../core/localization/locale_state.dart';
import '../../../../../core/theme/theme_cubit.dart';
import '../../../../../l10n/app_localizations.dart';

class GuestSettingsSheet extends StatelessWidget {
  const GuestSettingsSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context)!;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(tr.settings, style: Theme.of(context).textTheme.titleLarge),

            const SizedBox(height: 16),

            BlocBuilder<ThemeCubit, ThemeMode>(
              builder: (context, themeMode) {
                return ListTile(
                  leading: const Icon(Icons.dark_mode_outlined),
                  title: Text(tr.darkMode),
                  trailing: Switch(
                    value: themeMode == ThemeMode.dark,
                    onChanged: (_) {
                      context.read<ThemeCubit>().toggleTheme();
                    },
                  ),
                );
              },
            ),
            BlocBuilder<LocaleCubit, LocaleState>(
              builder: (context, localeState) {
                final isEnglish = localeState.locale.languageCode == 'en';

                return ListTile(
                  leading: const Icon(Icons.language),
                  title: Text(tr.language),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: CupertinoSlidingSegmentedControl<String>(
                      groupValue: isEnglish ? 'en' : 'ar',
                      children: const {
                        'ar': Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Text('العربية'),
                        ),
                        'en': Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Text('English'),
                        ),
                      },
                      onValueChanged: (_) {
                        context.read<LocaleCubit>().toggleLocale();
                      },
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
