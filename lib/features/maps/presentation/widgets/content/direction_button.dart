import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:smart_microbus/core/routing/routes.dart';
import 'package:smart_microbus/core/helpers/extensions.dart';

import '../../cubit/map_cubit.dart';

class DirectionButton extends StatelessWidget {
  const DirectionButton({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return BlocSelector<MapCubit, MapState, bool>(
      selector: (state) => state.loading,
      builder: (context, loading) {
        if (loading) {
          return const SizedBox.shrink();
        }

        return Positioned(
          right: 18.w,
          bottom: 180.h,
          child: FloatingActionButton(
            backgroundColor: colorScheme.primary,
            onPressed: () {
              context.pushNamed(Routes.routeScreen);
            },
            child: Icon(Icons.directions, color: colorScheme.onPrimary),
          ),
        );
      },
    );
  }
}
