import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_microbus/features/passener/presentation/cubit/passenger_cubit.dart';
import 'package:smart_microbus/l10n/app_localizations.dart';

class RouteSelectionCard extends StatefulWidget {
  const RouteSelectionCard({super.key});

  @override
  State<RouteSelectionCard> createState() => _RouteSelectionCardState();
}

class _RouteSelectionCardState extends State<RouteSelectionCard> {
  String? selectedCity;
  String? selectedRouteId;
  late PassengerCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = context.read<PassengerCubit>();
  }

  @override
  void dispose() {
    print('disposeed');
    cubit.resetRouteSelection();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cubit = context.watch<PassengerCubit>();
    final l10n = AppLocalizations.of(context)!;

    final state = cubit.state;

    final isLoadingDestinations = state is GetDestinationsLoading;

    if (state is GetDestinationsSuccess) {
      cubit.destinations = state.destinations;
    }

    final isDestinationEnabled = cubit.destinations.isNotEmpty;

    InputDecoration buildDecoration({Widget? suffix}) {
      return InputDecoration(
        filled: true,
        fillColor: theme.colorScheme.surface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        suffixIcon: suffix,
      );
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// ================= FROM =================
          Text(
            l10n.selectCity,
            style: theme.textTheme.labelMedium!.copyWith(color: Colors.grey),
          ),
          const SizedBox(height: 6),

          DropdownButtonFormField<String>(
            initialValue: selectedCity,
            menuMaxHeight: 200,
            hint: Text(l10n.selectCity),
            decoration: buildDecoration(),
            items: cubit.routes
                .map(
                  (e) => DropdownMenuItem(
                    value: e.cityName,
                    child: Text(e.cityName),
                  ),
                )
                .toList(),
            onChanged: (value) {
              setState(() {
                selectedCity = value;

                /// reset
                selectedRouteId = null;
                cubit.selectedRouteId = null;
                cubit.destinations = [];

                cubit.selectedCity = value;
                cubit.selectedDestination = null;
              });

              final selectedRoute = cubit.routes.firstWhere(
                (e) => e.cityName == value,
              );

              cubit.getRouteDestination(selectedRoute.stationId);
            },
          ),

          // }

          // return const SizedBox();
          // },
          // );
          const SizedBox(height: 16),

          /// ================= ICON =================
          Center(
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: theme.colorScheme.primary.withAlpha(30),
              ),
              child: Icon(Icons.swap_vert, color: theme.colorScheme.primary),
            ),
          ),

          const SizedBox(height: 16),

          /// ================= TO =================
          Text(
            l10n.selectDestination,
            style: theme.textTheme.labelMedium!.copyWith(color: Colors.grey),
          ),
          const SizedBox(height: 6),

          DropdownButtonFormField2<String>(
            valueListenable: ValueNotifier(selectedRouteId),

            isExpanded: true,

            hint: Text(l10n.selectDestination),

            decoration: buildDecoration(
              suffix: isLoadingDestinations
                  ? const Padding(
                      padding: EdgeInsets.all(10),
                      child: SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    )
                  : null,
            ),

            dropdownStyleData: const DropdownStyleData(maxHeight: 200),

            items: cubit.destinations.map((e) {
              return DropdownItem<String>(value: e.routeId, child: Text(e.to));
            }).toList(),

            onChanged: isDestinationEnabled
                ? (value) {
                    setState(() {
                      selectedRouteId = value;

                      cubit.selectedRouteId = value;

                      cubit.selectedDestination = cubit.destinations.firstWhere(
                        (e) => e.routeId == value,
                      );
                    });
                  }
                : null,
          ),
        ],
      ),
    );
  }
}
