/// presentation/widgets/trip/trip_route_section.dart

import 'package:flutter/material.dart';

import 'trip_route_item.dart';

class TripRouteSection extends StatelessWidget {
  final String routeFrom;
  final String routeTo;
  final String startTitle;
  final String endTitle;

  const TripRouteSection({
    super.key,
    required this.routeFrom,
    required this.routeTo,
    required this.startTitle,
    required this.endTitle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            theme.colorScheme.surface.withOpacity(.92),
            theme.colorScheme.surfaceContainerHighest.withOpacity(.72),
          ],
        ),
      ),
      child: Column(
        children: [
          TripRouteItem(
            color: theme.colorScheme.primary,
            title: startTitle,
            value: routeFrom,
          ),

          TripRouteItem(
            color: Colors.greenAccent,
            title: endTitle,
            value: routeTo,
            isLast: true,
          ),
        ],
      ),
    );
  }
}