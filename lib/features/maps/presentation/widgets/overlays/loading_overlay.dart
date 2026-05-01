import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/map_cubit.dart';

class LoadingOverlay extends StatelessWidget {
  const LoadingOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<MapCubit, MapState, bool>(
      selector: (state) => state.loading,
      builder: (context, loading) {
        if (!loading) {
          return const SizedBox.shrink();
        }

        return Container(
          color: Colors.white,
          child: const Center(
            child: CircularProgressIndicator(color: Colors.cyan),
          ),
        );
      },
    );
  }
}
