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
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    final cubit = context.read<DriverHomeCubit>();

    if (cubit.tripHistory == null) {
      cubit.getTripHistory();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToTop() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOutCubic,
      );
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
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 350),
                    switchInCurve: Curves.easeOut,
                    switchOutCurve: Curves.easeIn,
                    child: ListView.separated(
                      key: ValueKey(cubit.currentPage),
                      controller: _scrollController,
                      padding: const EdgeInsets.all(16),
                      itemCount: trips.data.trips.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (_, index) {
                        final trip = trips.data.trips[index];
                        return TripCard(trip: trip);
                      },
                    ),
                  ),
                ),

                _buildPagination(cubit),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildPagination(DriverHomeCubit cubit) {
    final page = cubit.currentPage;
    final total = cubit.totalPages;

    Widget pageItem(int number) {
      final isSelected = number == page;

      return GestureDetector(
        onTap: () {
          cubit.getTripHistory(pageNumber: number);
          _scrollToTop();
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          padding: EdgeInsets.symmetric(
            horizontal: isSelected ? 16 : 12,
            vertical: isSelected ? 10 : 8,
          ),
          decoration: BoxDecoration(
            color: isSelected
                ? Theme.of(context).colorScheme.primary
                : Colors.grey.shade200,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            "$number",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: isSelected ? 16 : 14,
              color: isSelected ? Colors.white : Colors.black87,
            ),
          ),
        ),
      );
    }

    Widget dots() {
      return const Padding(
        padding: EdgeInsets.symmetric(horizontal: 6),
        child: Text("..."),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: page > 1
                ? () {
                    cubit.getTripHistory(pageNumber: page - 1);
                    _scrollToTop();
                  }
                : null,
          ),

          pageItem(1),

          if (page != 1 && page != total) pageItem(page),

          if (page < total - 1) dots(),

          if (total > 1) pageItem(total),

          IconButton(
            icon: const Icon(Icons.chevron_right),
            onPressed: page < total
                ? () {
                    cubit.getTripHistory(pageNumber: page + 1);
                    _scrollToTop();
                  }
                : null,
          ),
        ],
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
        pageNumber: 1,
      );
    }
  }

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
