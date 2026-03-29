import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_microbus/features/passener/domain/entities/favourite_route_entity.dart';
import 'package:smart_microbus/l10n/app_localizations.dart';

import '../../../../core/helpers/extensions.dart';
import '../../../../core/routing/routes.dart';
import '../cubit/passenger_cubit.dart';

class FavouriteRouteCard extends StatelessWidget {
  final FavouriteRouteEntity route;
  final VoidCallback onRemove;

  const FavouriteRouteCard({
    super.key,
    required this.route,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final isArabic = Directionality.of(context) == TextDirection.rtl;
    return InkWell(
      onTap: () {
        final cubit = context.read<PassengerCubit>();

        cubit.getAllRouteData(route.routeId);

        context.pushNamed(
          Routes.passengerSearchResultScreen,
          arguments: route.routeId,
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            /// ================= TOP =================
            Row(
              children: [
                /// 📍 من → إلى
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isArabic
                            ? "${route.from} ← ${route.to}"
                            : "${route.from} → ${route.to}",
                        style: theme.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(l10n.routeLabel, style: theme.textTheme.bodySmall),
                    ],
                  ),
                ),

                /// ❤️ Remove Button
                IconButton(
                  onPressed: onRemove,
                  icon: Icon(
                    Icons.favorite,
                    color: theme.colorScheme.primary.withOpacity(0.8),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // /// ================= BOTTOM =================
            // Row(
            //   children: [
            //     /// 💰 السعر
            //     Expanded(
            //       child: Container(
            //         padding: const EdgeInsets.all(12),
            //         decoration: BoxDecoration(
            //           color:
            //               theme.colorScheme.primary.withOpacity(0.1),
            //           borderRadius: BorderRadius.circular(12),
            //         ),
            //         child: Column(
            //           children: [
            //             Text(
            //               l10n.
            //               priceLabel
            //               ,
            //               style: theme.textTheme.bodySmall,
            //             ),
            //             const SizedBox(height: 4),
            //             Text(
            //               l10n.priceInCurrency(route.price),
            //               style: theme.textTheme.bodyMedium?.copyWith(
            //                 fontWeight: FontWeight.bold,
            //               ),
            //             ),
            //           ],
            //         ),
            //       ),
            //     ),

            //     const SizedBox(width: 10),

            // /// 🚌 Route ID
            // Expanded(
            //   child: Container(
            //     padding: const EdgeInsets.all(12),
            //     decoration: BoxDecoration(
            //       color:
            //           theme.colorScheme.primary.withOpacity(0.1),
            //       borderRadius: BorderRadius.circular(12),
            //     ),
            //     child: Column(
            //       children: [
            //         Text(
            //           l10n.
            //           routeLabel
            //           ,
            //           style: theme.textTheme.bodySmall,
            //         ),
            //         const SizedBox(height: 4),
            //         Text(
            //           route.,
            //           style: theme.textTheme.bodyMedium?.copyWith(
            //             fontWeight: FontWeight.bold,
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            // ],
            // ),
          ],
        ),
      ),
    );
  }
}
