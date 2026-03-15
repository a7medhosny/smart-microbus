import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_microbus/core/helpers/show_toast_helper.dart';
import 'package:smart_microbus/features/Driver/driver_home/presentation/cubit/driver_home_cubit.dart';

import '../../../../../l10n/app_localizations.dart';
import '../widgets/tripHistory/date_filter_info.dart';
import '../widgets/tripHistory/trip_card.dart';
import '../widgets/tripHistory/trip_header.dart';

class DriverTripHistoryScreen extends StatefulWidget {
  const DriverTripHistoryScreen({super.key});

  @override
  State<DriverTripHistoryScreen> createState() =>
      _DriverTripHistoryScreenState();
}

class _DriverTripHistoryScreenState extends State<DriverTripHistoryScreen> {
  @override
  void initState() {
    super.initState();

    final cubit = context.read<DriverHomeCubit>();

    /// تحميل الداتا مرة واحدة فقط
    if (cubit.tripHistory == null) {
      cubit.getTripHistory();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: TripsAppBar(
        onFilterPressed: _selectDateRange,
        total:
            context
                .watch<DriverHomeCubit>()
                .tripHistory
                ?.data
                .totalAmount
                .toInt() ??
            0,
      ),
      body: SafeArea(
        child: BlocConsumer<DriverHomeCubit, DriverHomeState>(
          buildWhen: (previous, current) =>
              current is GetTripHistoryLoading ||
              current is GetTripHistorySuccess ||
              current is GetTripHistoryError,
          listener: (context, state) {
            if (state is GetTripHistoryError) {
              ShowToastHelper.showToast(
                context,
                state.message,
                backgroundColor: Colors.redAccent,
                icon: Icons.error,
              );
            }
          },
          builder: (context, state) {
            final cubit = context.watch<DriverHomeCubit>();
            if (state is GetTripHistoryLoading && cubit.tripHistory == null) {
              return Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.primary,
                ),
              );
            }

            final trips = cubit.tripHistory;
            if (trips == null) {
              return const SizedBox();
            }

            if (trips.data.trips.isEmpty) {
              return _buildEmptyList(l10n);
            }

            return Column(
              children: [
                DateFilterInfo(cubit: cubit),
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: trips.data.trips.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (_, index) {
                      final trip = trips.data.trips[index];
                      return TripCard(trip: trip);
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Future<void> _selectDateRange() async {
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020, 1, 1),
      lastDate: DateTime.now(),
      initialDateRange: DateTimeRange(
        start: DateTime.now().subtract(const Duration(days: 7)),
        end: DateTime.now(),
      ),
    );

    if (picked != null) {
      context.read<DriverHomeCubit>().getTripHistory(
        fromDate: picked.start,
        toDate: picked.end,
      );
    }
  }

  /// ================= EMPTY LIST =================

  Widget _buildEmptyList(AppLocalizations l10n) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.history_toggle_off,
              size: 80,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 20),
            Text(
              l10n.noTripsTitle,
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              l10n.noTripsDescription,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
