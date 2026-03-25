import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_microbus/features/passener/presentation/cubit/passenger_cubit.dart';
import 'package:smart_microbus/features/passener/presentation/widgets/search_result_widgets/route_summary_card.dart';
import 'package:smart_microbus/features/passener/presentation/widgets/search_result_widgets/section_card.dart';
import 'package:smart_microbus/l10n/app_localizations.dart';

import '../../../../core/helpers/extensions.dart';
import '../../../../core/routing/routes.dart';

class SearchResultScreen extends StatelessWidget {
  final String routeId;
  const SearchResultScreen({super.key , required this.routeId});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.searchResults)),
      body: BlocBuilder<PassengerCubit, PassengerState>(
        buildWhen: (previous, current) =>
            current is PassengerDataState || current is PassengerDataError,
        builder: (context, state) {
          /// ================= LOADING =================
          if (state is PassengerDataState && state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          /// ================= ERROR =================
          if (state is PassengerDataError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 60, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    state.message,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      final cubit = context.read<PassengerCubit>();
                      final routeId = cubit.selectedRouteId;

                      if (routeId != null) {
                        cubit.getAllRouteData(routeId);
                      }
                    },
                    child: Text(l10n.retry),
                  ),
                ],
              ),
            );
          }

          /// ================= SUCCESS =================
          if (state is PassengerDataState) {
            final summary = state.summary;
            final station = state.station ?? [];
            final onTheWay = state.onTheWay ?? [];

            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                if (summary != null) RouteSummaryCard(summary: summary, routeId: routeId,),

                const SizedBox(height: 20),

                SectionCard(
                  title: l10n.availableAtStation,
                  count: station.length,
                  icon: Icons.directions_bus,
                  onTap: () {
                    context.pushNamed(
                      Routes.stationListScreen,
                      arguments: station,
                    );
                  },
                ),

                const SizedBox(height: 16),

                SectionCard(
                  title: l10n.onTheWay,
                  count: onTheWay.length,
                  icon: Icons.access_time,
                  onTap: () {
                    context.pushNamed(
                      Routes.onTheWayListScreen,
                      arguments: onTheWay,
                    );
                  },
                ),
              ],
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
