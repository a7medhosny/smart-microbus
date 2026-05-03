import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_microbus/l10n/app_localizations.dart';

import '../../../domain/entities/station_entity.dart';
import '../../cubit/map_cubit.dart';

class SearchResults extends StatelessWidget {
  const SearchResults({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;

    return BlocSelector<MapCubit, MapState, (String, List<StationEntity>)>(
      selector: (state) => (state.searchQuery, state.stations),
      builder: (context, data) {
        final query = data.$1;
        final stations = data.$2;

        if (query.isEmpty) return const SizedBox();

        final results = stations.where((station) {
          return station.name.toLowerCase().contains(query.toLowerCase());
        }).toList();

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            constraints: const BoxConstraints(maxHeight: 250),
            margin: const EdgeInsets.only(top: 4),
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: colorScheme.shadow.withOpacity(0.1),
                  blurRadius: 8,
                ),
              ],
            ),
            child: results.isEmpty
                ? Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      loc.noStationsFound,
                      style: TextStyle(color: colorScheme.onSurfaceVariant),
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: results.length,
                    itemBuilder: (context, index) {
                      final station = results[index];

                      return ListTile(
                        title: Text(
                          station.name,
                          style: TextStyle(color: colorScheme.onSurface),
                        ),

                        tileColor: Colors.transparent,
                        iconColor: colorScheme.primary,

                        onTap: () {
                          context.read<MapCubit>().controller.value =
                              TextEditingValue(text: station.name);

                          context.read<MapCubit>().getStationRoute(station);

                          context.read<MapCubit>().updateSearchQuery('');
                        },
                      );
                    },
                  ),
          ),
        );
      },
    );
  }
}
