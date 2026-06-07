import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_microbus/features/passener/presentation/cubit/passenger_cubit.dart';
import 'package:smart_microbus/features/passener/presentation/widgets/search_result_widgets/empty_state.dart';
import 'package:smart_microbus/features/passener/presentation/widgets/search_result_widgets/microbus_card.dart';
import 'package:smart_microbus/l10n/app_localizations.dart';

class StationListScreen extends StatefulWidget {
  final String routeId;

  const StationListScreen({super.key, required this.routeId});

  @override
  State<StationListScreen> createState() => _StationListScreenState();
}

class _StationListScreenState extends State<StationListScreen> {
  @override
  void initState() {
    super.initState();

    context.read<PassengerCubit>().getStationMicrobuses(widget.routeId);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.microbusesAtStation)),
      body: BlocBuilder<PassengerCubit, PassengerState>(
        buildWhen: (previous, current) =>
            current is GetStationMicrobusesLoading ||
            current is GetStationMicrobusesSuccess ||
            current is GetStationMicrobusesError,
        builder: (context, state) {
          if (state is GetStationMicrobusesLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is GetStationMicrobusesError) {
            return Center(child: Text(state.message));
          }

          if (state is GetStationMicrobusesSuccess) {
            final stationMicrobuses = state.microbuses;

            if (stationMicrobuses.isEmpty) {
              return EmptyState(
                title: l10n.noMicrobuses,
                description: l10n.noMicrobusesDesc,
                icon: Icons.directions_bus_outlined,
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: stationMicrobuses.length,
              itemBuilder: (context, index) {
                return MicrobusCard.fromStation(stationMicrobuses[index]);
              },
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
