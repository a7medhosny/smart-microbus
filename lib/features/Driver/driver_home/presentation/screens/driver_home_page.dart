import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_microbus/core/helpers/show_toast_helper.dart';
import 'package:smart_microbus/core/helpers/spacing.dart';
import 'package:smart_microbus/features/Driver/driver_home/presentation/cubit/driver_home_cubit.dart';

import '../../../../../core/helpers/app_error_helper.dart';
import '../../../../../l10n/app_localizations.dart';
import '../../domain/entities/driver_current_status.dart';
import '../widgets/earnings_summary_section.dart';
import '../widgets/header_card.dart';
import '../widgets/queue_Status.dart';
import '../widgets/queue_list.dart';
import '../widgets/started_trip.dart';

class DriverHomeView extends StatefulWidget {
  const DriverHomeView({super.key});

  @override
  State<DriverHomeView> createState() => _DriverHomeViewState();
}

class _DriverHomeViewState extends State<DriverHomeView> {
  @override
  void initState() {
    super.initState();

    final cubit = context.read<DriverHomeCubit>();
    cubit.connectQueueGlobal();
    cubit.getCurrentPosition();
    cubit.getEstimatedDailyEarnings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: BlocConsumer<DriverHomeCubit, DriverHomeState>(
          listener: (context, state) {
            if (state is GetCurrentPositionError) {
              ShowToastHelper.showToast(
                context,
                state.message,
                backgroundColor: Colors.red,
                icon: Icons.error_outline,
              );
            }
          },

          // builder: (context, state) {
          //   final cubit = context.watch<DriverHomeCubit>();
          //   if (state is GetCurrentPositionError) {
          //     return _errorState(context, state.message);
          //   }

          //   /// ================= LOADING =================
          //   if (!cubit.positionLoaded || state is GetCurrentPositionLoading) {
          //     return const Center(child: CircularProgressIndicator());
          //   }

          //   final status = cubit.currentStatus;

          //   /// ================= NO DATA =================
          //   if (status == null) {
          //     return _emptyState(context);
          //   }

          //   return RefreshIndicator(
          //     onRefresh: () async {
          //       await context.read<DriverHomeCubit>().getCurrentPosition();
          //     },
          //     child: SingleChildScrollView(
          //       physics: const AlwaysScrollableScrollPhysics(),
          //       padding: const EdgeInsets.all(16),
          //       child: Column(
          //         children: [
          //           const HeaderCard(),
          //           verticalSpace(20),

          //           /// 👇 dynamic UI based on status
          //           // AnimatedSwitcher(
          //           //   duration: const Duration(milliseconds: 300),
          //           //   child: _buildBodyByStatus(status),
          //           // ),
          //           AnimatedSwitcher(
          //             duration: const Duration(milliseconds: 500),
          //             switchInCurve: Curves.easeOut,
          //             switchOutCurve: Curves.easeIn,
          //             transitionBuilder: (child, animation) {
          //               final slideAnimation = Tween<Offset>(
          //                 begin: const Offset(0, 0.1),
          //                 end: Offset.zero,
          //               ).animate(animation);

          //               return FadeTransition(
          //                 opacity: animation,
          //                 child: SlideTransition(
          //                   position: slideAnimation,
          //                   child: child,
          //                 ),
          //               );
          //             },
          //             child: _buildBodyByStatus(status),
          //           ),
          //         ],
          //       ),
          //     ),
          //   );
          // },
          buildWhen: (previous, current) =>
              current is GetCurrentPositionLoading ||
              current is GetCurrentPositionSuccess ||
              current is GetCurrentPositionError,

          builder: (context, state) {
            final cubit = context.watch<DriverHomeCubit>();

            /// ================= LOADING =================
            if (state is GetCurrentPositionLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            /// ================= ERROR =================
            if (state is GetCurrentPositionError) {
              return AppErrorWidget(
                message: state.message,
                onRetry: () {
                  context.read<DriverHomeCubit>().getCurrentPosition();
                },
              );
            }

            /// ================= SUCCESS =================
            if (state is GetCurrentPositionSuccess) {
              final status = state.currentStatus;

              return RefreshIndicator(
                onRefresh: () async {
                  await context.read<DriverHomeCubit>().getCurrentPosition();
                },
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      const HeaderCard(),
                      verticalSpace(20),

                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 500),
                        switchInCurve: Curves.easeOut,
                        switchOutCurve: Curves.easeIn,
                        transitionBuilder: (child, animation) {
                          final slideAnimation = Tween<Offset>(
                            begin: const Offset(0, 0.1),
                            end: Offset.zero,
                          ).animate(animation);

                          return FadeTransition(
                            opacity: animation,
                            child: SlideTransition(
                              position: slideAnimation,
                              child: child,
                            ),
                          );
                        },
                        child: _buildBodyByStatus(status),
                      ),
                    ],
                  ),
                ),
              );
            }

            /// ================= INITIAL =================
            return const SizedBox();
          },
        ),
      ),
    );
  }

  Widget _emptyState(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// Icon
            Icon(
              Icons.inbox_outlined,
              size: 80,
              color: theme.colorScheme.primary.withOpacity(.6),
            ),

            const SizedBox(height: 20),

            /// Title
            Text(
              l10n.noDataTitle,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            /// Description
            Text(
              l10n.noDataDescription,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),

            const SizedBox(height: 24),

            /// Retry Button
            ElevatedButton.icon(
              onPressed: () {
                context.read<DriverHomeCubit>().getCurrentPosition();
              },
              icon: const Icon(Icons.refresh),
              label: Text(l10n.retry),
            ),
          ],
        ),
      ),
    );
  }

  /// ================= SWITCH UI =================
  Widget _buildBodyByStatus(DriverCurrentStatus status) {
    if (status.isOnTrip) {
      return _onTripUI(status);
    } else if (status.isInQueue) {
      return _inQueueUI(status);
    } else {
      return _availableUI();
    }
  }

  /// ================= ON TRIP =================
  Widget _onTripUI(DriverCurrentStatus status) {
    context.read<DriverHomeCubit>().turnNotified = false;

    return const Column(
      key: ValueKey('onTrip'),
      children: [StartedTripSection()],
    );
  }

  /// ================= IN QUEUE =================
  Widget _inQueueUI(DriverCurrentStatus status) {
    // final cubit = context.watch<DriverHomeCubit>();

    // final queue = cubit.queue;
    // final myPos = cubit.myPosition;

    // /// ================= LOADING =================
    // if (queue == null || myPos == null) {
    //   return const Center(
    //     child: Padding(
    //       padding: EdgeInsets.all(20),
    //       child: CircularProgressIndicator(),
    //     ),
    //   );
    // }

    // // /// ================= EMPTY QUEUE =================
    // // if (queue.isEmpty) {
    // //   return _emptyQueue(context);
    // // }

    /// ================= NORMAL UI =================
    return Column(
      key: const ValueKey('inQueue'),
      children: const [
        QueueStatusSection(),
        SizedBox(height: 20),
        QueueListSection(),
        SizedBox(height: 20),
        EarningsSummarySection(),
      ],
    );
  }

  /// ================= AVAILABLE =================
  Widget _availableUI() {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      key: const ValueKey('available'),
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * .25),
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Icon(
            Icons.qr_code_scanner,
            size: 70,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: 20),
          Text(
            l10n.driverNotInQueueTitle,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 10),
          Text(
            l10n.driverNotInQueueDescription,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
