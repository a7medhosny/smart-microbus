/// presentation/screens/in_queue_section.dart
library;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



import '../../../../../../core/helpers/app_error_helper.dart';
import '../../../../../../core/helpers/spacing.dart';
import '../../cubit/driver_home_cubit.dart';
import 'queue_empty_state.dart';
import 'queue_header.dart';
import 'queue_info_cards.dart';
import 'queue_list.dart';
import 'queue_skeleton.dart';

class InQueueSection extends StatelessWidget {
  const InQueueSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DriverHomeCubit, DriverHomeState>(
      listener: (context, state) {},

      builder: (context, state) {
        final cubit = context.read<DriverHomeCubit>();

        final queue = cubit.queue;
        final myPos = cubit.myPosition;

        /// ================= LOADING =================
        if (state is GetCurrentPositionLoading ||
            state is GetStationQueueLoading) {
          return const Padding(
            padding: EdgeInsets.all(16),
            child: QueueSkeleton(),
          );
        }

        if (queue == null || myPos == null) {
          return const Padding(
            padding: EdgeInsets.all(16),
            child: QueueSkeleton(),
          );
        }

        /// ================= ERROR =================
        if (state is GetCurrentPositionError) {
          return AppErrorWidget(
            message: state.message,
            onRetry: () {},
          );
        }

        if (state is GetStationQueueError) {
          return AppErrorWidget(
            message: state.message,
            onRetry: () {},
          );
        }

        /// ================= EMPTY =================
        if (queue.isEmpty) {
          return const QueueEmptyState();
        }

        /// ================= DATA =================
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            QueueHeader(queueLength: queue.length),

            verticalSpace(18),

            QueueInfoCards(
              vehiclesAhead: cubit.getVehiclesAhead(),
            ),

            verticalSpace(22),

            QueueList(
              queue: queue,
              currentDriverId: cubit.currentStatus?.driverId,
            ),
          ],
        );
      },
    );
  }
}