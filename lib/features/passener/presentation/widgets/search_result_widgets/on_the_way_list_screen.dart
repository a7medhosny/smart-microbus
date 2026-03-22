import 'package:flutter/material.dart';
import 'package:smart_microbus/features/passener/presentation/widgets/search_result_widgets/empty_state.dart';
import 'package:smart_microbus/features/passener/presentation/widgets/search_result_widgets/microbus_card.dart';
import 'package:smart_microbus/l10n/app_localizations.dart';

class OnTheWayListScreen extends StatelessWidget {
  final List onTheWay;

  const OnTheWayListScreen({super.key, required this.onTheWay});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.comingToYou)),
      body: onTheWay.isEmpty
          ? EmptyState(
              title: l10n.noMicrobuses,
              description: l10n.noMicrobusesDesc,
              icon: Icons.directions_bus_outlined,
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: onTheWay.length,
              itemBuilder: (context, index) {
                return MicrobusCard.fromOnTheWay(onTheWay[index]);
              },
            ),
    );
  }
}