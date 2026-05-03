import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_microbus/features/maps/presentation/widgets/content/search_results.dart';

import '../../../../../core/helpers/spacing.dart';

import '../../cubit/map_cubit.dart';
import 'bottom_card.dart';
import 'search_bar.dart';
import 'stations_list.dart';

class MapContent extends StatelessWidget {
  const MapContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<MapCubit, MapState, bool>(
      selector: (state) => state.loading,
      builder: (context, loading) {
        if (loading) {
          return const SizedBox.shrink();
        }

        return SafeArea(
          child: Column(
            children: [
              verticalSpace(10),

              SearchBarWidget(),

              verticalSpace(14),

              StationsList(),

              Spacer(),

              BottomCard(),
            ],
          ),
        );
      },
    );
  }
}
