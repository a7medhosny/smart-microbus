import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_microbus/core/helpers/spacing.dart';
import 'package:smart_microbus/features/Driver/driver_home/presentation/cubit/driver_home_cubit.dart';

import '../widgets/earnings_summary_section.dart';
import '../widgets/header_card.dart';
import '../widgets/queue_Status.dart';
import '../widgets/queue_list.dart';

class DriverHomeView extends StatefulWidget {
  const DriverHomeView({super.key, required this.userName});
  final String userName;
  @override
  State<DriverHomeView> createState() => _DriverHomeViewState();
}

class _DriverHomeViewState extends State<DriverHomeView> {
  @override
  void initState() {
    context.read<DriverHomeCubit>().getCurrentPosition();
    context.read<DriverHomeCubit>().getStationQueue(stationId: '', routeId: '');
    context.read<DriverHomeCubit>().getEstimatedDailyEarnings();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              HeaderCard(user: widget.userName),
              verticalSpace(20),
              QueueStatusSection(),
              verticalSpace(20),
              QueueListSection(),
              verticalSpace(20),
              EarningsSummarySection(),
            ],
          ),
        ),
      ),
    );
  }
}
