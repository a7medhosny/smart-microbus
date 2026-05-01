import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/helpers/show_toast_helper.dart';
import '../cubit/map_cubit.dart';
import '../widgets/content/direction_button.dart';
import '../widgets/content/map_content.dart';
import '../widgets/map/map_view.dart';
import '../widgets/overlays/loading_overlay.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return BlocListener<MapCubit, MapState>(
      listenWhen: (previous, current) =>
          previous.errorMessage != current.errorMessage,
      listener: (context, state) {
        final message = state.errorMessage;

        if (message == null) return;

        ShowToastHelper.showToast(
          context,
          message,
          backgroundColor: colorScheme.error,
        );
      },
      child: const Scaffold(
        body: Stack(
          children: [
            MapView(),
            LoadingOverlay(),
            MapContent(),
            DirectionButton(),
          ],
        ),
      ),
    );
  }
}
