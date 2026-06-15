import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_microbus/features/passener/presentation/cubit/passenger_cubit.dart';
import 'package:smart_microbus/features/passener/presentation/widgets/search_result_widgets/empty_state.dart';
import 'package:smart_microbus/features/passener/presentation/widgets/search_result_widgets/microbus_card.dart';
import 'package:smart_microbus/l10n/app_localizations.dart';

class OnTheWayListScreen extends StatefulWidget {
  final String routeId;

  const OnTheWayListScreen({super.key, required this.routeId});

  @override
  State<OnTheWayListScreen> createState() => _OnTheWayListScreenState();
}

class _OnTheWayListScreenState extends State<OnTheWayListScreen> {
  @override
  void initState() {
    super.initState();

    context.read<PassengerCubit>().getOnTheWayMicrobuses(widget.routeId);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.comingToYou)),
      body: BlocBuilder<PassengerCubit, PassengerState>(
        buildWhen: (previous, current) =>
            current is GetOnTheWayMicrobusesLoading ||
            current is GetOnTheWayMicrobusesSuccess ||
            current is GetOnTheWayMicrobusesError,
        builder: (context, state) {
          if (state is GetOnTheWayMicrobusesLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is GetOnTheWayMicrobusesError) {
            return Center(child: Text(state.message));
          }

          if (state is GetOnTheWayMicrobusesSuccess) {
            final onTheWay = state.microbuses;

            if (onTheWay.isEmpty) {
              return RefreshIndicator(
                onRefresh: () async {
                  await context.read<PassengerCubit>().getOnTheWayMicrobuses(
                    widget.routeId,
                  );
                },
                child: ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: EmptyState(
                        title: l10n.noMicrobuses,
                        description: l10n.noMicrobusesDesc,
                        icon: Icons.directions_bus_outlined,
                      ),
                    ),
                  ],
                ),
              );
            }

            return RefreshIndicator(
              onRefresh: () async {
                await context.read<PassengerCubit>().getOnTheWayMicrobuses(
                  widget.routeId,
                );
              },
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: onTheWay.length,
                itemBuilder: (context, index) {
                  return MicrobusCard.fromOnTheWay(onTheWay[index]);
                },
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
