import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_microbus/features/passener/presentation/cubit/passenger_cubit.dart';
import 'package:smart_microbus/features/passener/presentation/widgets/search_result_widgets/route_summary_card.dart';
import 'package:smart_microbus/features/passener/presentation/widgets/search_result_widgets/section_card.dart';
import 'package:smart_microbus/l10n/app_localizations.dart';

import '../../../../core/helpers/app_error_helper.dart';
import '../../../../core/helpers/extensions.dart';
import '../../../../core/routing/routes.dart';

class SearchResultScreen extends StatefulWidget {
  final String routeId;
  const SearchResultScreen({super.key, required this.routeId});

  @override
  State<SearchResultScreen> createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  @override
  void initState() {
    super.initState();

    context.read<PassengerCubit>().connectToRouteTracking(widget.routeId);
  }

  @override
  void dispose() {
    context.read<PassengerCubit>().disconnectRouteTracking();

    super.dispose();
  }

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
            return AppErrorWidget(
              message: state.message,
              onRetry: () {
                final cubit = context.read<PassengerCubit>();
                final routeId = cubit.selectedRouteId;

                if (routeId != null) {
                  cubit.getAllRouteData(routeId);
                }
              },
            );
          }

          /// ================= SUCCESS =================
          if (state is PassengerDataState) {
            final summary = state.summary;
            final station = state.station ?? [];
            final onTheWay = state.onTheWay ?? [];
            final cubit = context.read<PassengerCubit>();
            final tracking = context.watch<PassengerCubit>().routeTracking;
            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                if (summary != null)
                  RouteSummaryCard(summary: summary, routeId: widget.routeId),

                const SizedBox(height: 20),

                SectionCard(
                  title: l10n.availableAtStation,
                  count: tracking?.numberOfMicrobusesInQueue ?? station.length,
                  icon: Icons.directions_bus,
                  onTap: () {
                    cubit.currentNavigatorKey.currentState?.pushNamed(
                      Routes.stationListScreen,
                      arguments: widget.routeId,
                    );
                  },
                ),

                const SizedBox(height: 16),

                SectionCard(
                  title: l10n.onTheWay,
                  count:
                      tracking?.numberOfMicrobusesOnTheWay ?? onTheWay.length,
                  icon: Icons.access_time,
                  onTap: () {
                    context.pushNamed(
                      Routes.onTheWayListScreen,
                      arguments: widget.routeId,
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
