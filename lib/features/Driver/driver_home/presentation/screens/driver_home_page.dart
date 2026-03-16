import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_microbus/core/helpers/show_toast_helper.dart';
import 'package:smart_microbus/core/helpers/spacing.dart';
import 'package:smart_microbus/features/Driver/driver_home/presentation/cubit/driver_home_cubit.dart';

import '../../../../../core/networking/dio_factory.dart';
import '../../../../../l10n/app_localizations.dart';
import '../widgets/earnings_summary_section.dart';
import '../widgets/header_card.dart';
import '../widgets/queue_Status.dart';
import '../widgets/queue_list.dart';

class DriverHomeView extends StatefulWidget {
  const DriverHomeView({super.key});

  @override
  State<DriverHomeView> createState() => _DriverHomeViewState();
}

class _DriverHomeViewState extends State<DriverHomeView> {
  @override
  void initState() {
    super.initState();
                  //TODO: remove this after testing

              testRefreshToken();

    final cubit = context.read<DriverHomeCubit>();
    cubit.getCurrentPosition();
    cubit.getEstimatedDailyEarnings();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: BlocConsumer<DriverHomeCubit, DriverHomeState>(
          listener: (context, state) {
            if (state is GetCurrentPositionError) {
              ShowToastHelper.showToast(context, state.message);
            }
          },
          builder: (context, state) {
            final cubit = context.watch<DriverHomeCubit>();

            /// ================= FIRST LOADING =================
            if (!cubit.positionLoaded) {
              return const Center(child: CircularProgressIndicator());
            }

            final position = cubit.myPosition;

            /// ================= DRIVER NOT IN QUEUE =================
            if (position == null ||
                position.queueId == '00000000-0000-0000-0000-000000000000') {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    HeaderCard(),
                    verticalSpace(20),
                    Center(child: _notInQueueBody(l10n)),
                  ],
                ),
              );
            }

            /// ================= DRIVER IN QUEUE =================
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [HeaderCard(), verticalSpace(20), _driverHomeBody()],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _driverHomeBody() {
    return Column(
      children: const [
        QueueStatusSection(),
        SizedBox(height: 20),
        QueueListSection(),
        SizedBox(height: 20),
        EarningsSummarySection(),
      ],
    );
  }

  Widget _notInQueueBody(AppLocalizations l10n) {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * .25),
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Icon(
            Icons.qr_code_scanner,
            size: 70,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: 20),
          Text(
            l10n.driverNotInQueueTitle,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 10),
          Text(
            l10n.driverNotInQueueDescription,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
