import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_microbus/l10n/app_localizations.dart';
import '../../../../../core/auth/token_manager.dart';
import '../../cubit/passenger_cubit.dart';

class CurrentLocationCard extends StatelessWidget {
  const CurrentLocationCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final userName = (TokenManager.userName ?? '').split(' ').first;
    print("🟢🟢CurrentLocationCard build with userName: $userName");
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          colors: [
            theme.colorScheme.primary,
            theme.colorScheme.primary.withOpacity(.85),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /// 👤 Avatar
          InkWell(
            onTap: () {
              context.read<PassengerCubit>().changeBottomNavIndex(4);
            },
            child: CircleAvatar(
              radius: 24,
              backgroundColor: Colors.white.withOpacity(.15),
              child: const Icon(Icons.person, color: Colors.white, size: 20),
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /// Title + Icon
                Row(
                  children: [
                    Icon(
                      Icons.location_on_rounded,
                      color: Colors.white.withAlpha(180),
                      size: 16,
                    ),
                    const SizedBox(width: 8),

                    Expanded(
                      child: Text(
                        l10n.welcomeToUser(userName),
                        style: theme.textTheme.titleSmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 6),

                /// Description
                Text(
                  l10n.currentLocationHint,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Colors.white70,
                    height: 1.3, // spacing بين السطور أحسن
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
