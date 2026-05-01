import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helpers/spacing.dart';

import '../cubit/map_cubit.dart';
import '../widgets/route_widgets/route_empty_state.dart';
import '../widgets/route_widgets/route_header.dart';
import '../widgets/route_widgets/route_loading_widget.dart';
import '../widgets/route_widgets/route_map_view.dart';
import '../widgets/route_widgets/route_result_card.dart';
import '../widgets/route_widgets/transport_modes_row.dart';

class RouteScreen extends StatelessWidget {
  const RouteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return BlocListener<MapCubit, MapState>(
      listenWhen: (previous, current) =>
          previous.errorMessage != current.errorMessage,
      listener: (context, state) {
        final message = state.errorMessage;

        if (message == null) return;

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message), backgroundColor: colorScheme.error),
        );
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              verticalSpace(10),

              const RouteHeader(),

              verticalSpace(25),

              const TransportModesRow(),

              verticalSpace(25),

              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24.r),
                    child: BlocBuilder<MapCubit, MapState>(
                      builder: (context, state) {
                        if (state.routeLoading) {
                          return const RouteLoadingWidget();
                        }

                        final route = state.routeBetweenStations;

                        if (route == null ||
                            state.fromStation == null ||
                            state.toStation == null) {
                          return const RouteEmptyState();
                        }

                        return RouteMapView(
                          route: route,
                          from: state.fromStation!,
                          to: state.toStation!,
                        );
                      },
                    ),
                  ),
                ),
              ),

              verticalSpace(35),

              const RouteResultCard(),

              verticalSpace(20),
            ],
          ),
        ),
      ),
    );
  }
}
