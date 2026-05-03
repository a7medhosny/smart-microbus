import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../l10n/app_localizations.dart';

import '../cubit/passenger_location_cubit.dart';

import '../widgets/tracking/tracking_map_view.dart';

class DriverTrackingScreen extends StatefulWidget {
  final String driverId;

  const DriverTrackingScreen({super.key, required this.driverId});

  @override
  State<DriverTrackingScreen> createState() => _DriverTrackingScreenState();
}

class _DriverTrackingScreenState extends State<DriverTrackingScreen> {
  @override
  void initState() {
    super.initState();

    context.read<PassengerLocationCubit>().connect(widget.driverId);
  }

  Future<void> _handleExit() async {
    await context.read<PassengerLocationCubit>().disconnect();
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final loc = AppLocalizations.of(context)!;

    return PopScope(
      canPop: false,

      onPopInvoked: (didPop) async {
        if (didPop) return;

        await _handleExit();
      },
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
          title: Row(
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(100),
                ),
              ),

              const SizedBox(width: 8),

              Text(loc.liveTracking),
            ],
          ),
        ),

        body: SafeArea(
          child: BlocBuilder<PassengerLocationCubit, PassengerLocationState>(
            builder: (context, state) {
              final location = state.location;

              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),

                child: () {
                  // ================= LOADING =================

                  if (state.loading && location == null) {
                    return const _TrackingLoadingView();
                  }

                  // ================= ERROR =================

                  if (state.error != null && location == null) {
                    return _TrackingErrorView(
                      message: state.error!,
                      onRetry: () {
                        context.read<PassengerLocationCubit>().connect(
                          widget.driverId,
                        );
                      },
                    );
                  }

                  // ================= EMPTY =================

                  if (location == null || location.coordinates.isEmpty) {
                    return _TrackingEmptyView(
                      message: loc.noLiveLocationAvailable,
                    );
                  }

                  // ================= MAP =================

                  return Stack(
                    children: [
                      TrackingMapView(location: location),

                      if (state.loading)
                        const Positioned(
                          top: 16,
                          right: 16,
                          child: CircularProgressIndicator(),
                        ),
                    ],
                  );
                }(),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _TrackingLoadingView extends StatelessWidget {
  const _TrackingLoadingView();

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(),

          const SizedBox(height: 16),

          Text(loc.loadingTracking),
        ],
      ),
    );
  }
}

class _TrackingErrorView extends StatelessWidget {
  final String message;

  final VoidCallback onRetry;

  const _TrackingErrorView({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.location_off,
              size: 70,
              color: Theme.of(context).colorScheme.error,
            ),

            const SizedBox(height: 16),

            Text(message, textAlign: TextAlign.center),

            const SizedBox(height: 20),

            FilledButton(onPressed: onRetry, child: Text(loc.retry)),
          ],
        ),
      ),
    );
  }
}

class _TrackingEmptyView extends StatelessWidget {
  final String message;

  const _TrackingEmptyView({required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(message));
  }
}
