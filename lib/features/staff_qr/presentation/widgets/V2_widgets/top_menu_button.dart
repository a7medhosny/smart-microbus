import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_microbus/l10n/app_localizations.dart';

import '../../../../../core/auth/token_manager.dart';
import '../../../../../core/helpers/extensions.dart';
import '../../../../../core/localization/locale_cubit.dart';
import '../../../../../core/networking/dio_factory.dart';
import '../../../../../core/routing/routes.dart';
import '../../../../../core/theme/theme_cubit.dart';

class TopMenuButton extends StatelessWidget {
  const TopMenuButton({super.key});

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context)!;

    return PopupMenuButton<String>(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      onSelected: (value) {
        switch (value) {
          case "theme":
            context.read<ThemeCubit>().toggleTheme();
            break;

          case "language":
            context.read<LocaleCubit>().toggleLocale();
            break;

          case "logout":
            TokenManager.clearLoginData();

            DioFactory.removeAuthInterceptor();

            context.pushNamedAndRemoveUntil(Routes.login);

            break;
        }
      },
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            value: "theme",
            child: Text(tr.changeTheme),
          ),
          PopupMenuItem(
            value: "language",
            child: Text(tr.changeLanguage),
          ),
          const PopupMenuDivider(),
          PopupMenuItem(
            value: "logout",
            child: Text(tr.logout),
          ),
        ];
      },
    );
  }
}