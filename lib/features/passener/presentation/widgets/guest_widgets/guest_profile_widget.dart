import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_microbus/core/auth/session_manager.dart';
import 'package:smart_microbus/features/passener/presentation/cubit/passenger_cubit.dart';
import 'package:smart_microbus/l10n/app_localizations.dart';

import '../../../../../core/helpers/extensions.dart';
import '../../../../../core/routing/routes.dart';

class GuestProfileWidget extends StatelessWidget {
  const GuestProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tr = AppLocalizations.of(context)!;

    return SafeArea(
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              Container(
                width: 96,
                height: 96,

                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer.withAlpha(20),

                  shape: BoxShape.circle,
                ),

                child: Icon(
                  Icons.person_outline_rounded,

                  size: 46,

                  color: theme.colorScheme.primary,
                ),
              ),

              const SizedBox(height: 24),

              Text(
                tr.profile_title,

                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),

                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 10),

              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 320),

                child: Text(
                  tr.guest_profile_message,

                  textAlign: TextAlign.center,

                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                    height: 1.45,
                  ),
                ),
              ),

              const SizedBox(height: 32),

              SizedBox(
                width: double.infinity,

                child: FilledButton(
                  onPressed: () {
                    Navigator.pop(context);

                    context.pushReplacementNamedRoot(Routes.login);
                    context.read<PassengerCubit>().changeBottomNavIndex(0);
                  },

                  child: Text(tr.login),
                ),
              ),

              const SizedBox(height: 8),

              TextButton(
                onPressed: () {
                  Navigator.pop(context);

                  context.pushReplacementNamedRoot(Routes.register);
                },

                child: Text(tr.create_account),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
