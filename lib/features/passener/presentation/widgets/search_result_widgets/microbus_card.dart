import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_microbus/features/passener/domain/entities/on_the_way_microbus_entity.dart';
import 'package:smart_microbus/features/passener/domain/entities/station_microbus_entity.dart';
import 'package:smart_microbus/l10n/app_localizations.dart';

import '../../../domain/entities/all_report_request_entity.dart';
import '../../cubit/passenger_cubit.dart';
import '../../screens/report_details_screen.dart';
import '../../screens/report_screen.dart';

class MicrobusCard extends StatelessWidget {
  final String driverName;
  final String model;
  final String color;
  final String plateNumber;
  final int passengerCount;
  final int position;
  final String status;
  final int? estimatedArrivalMinutes;

  const MicrobusCard({
    super.key,
    required this.driverName,
    required this.model,
    required this.color,
    required this.plateNumber,
    required this.passengerCount,
    required this.position,
    required this.status,
    this.estimatedArrivalMinutes,
  });

  factory MicrobusCard.fromStation(StationMicrobusEntity bus) {
    return MicrobusCard(
      driverName: bus.driverName,
      model: bus.model,
      color: bus.color,
      plateNumber: bus.plateNumber,
      passengerCount: bus.passengerCount,
      position: bus.position,
      status: bus.status,
    );
  }

  factory MicrobusCard.fromOnTheWay(OnTheWayMicrobusEntity bus) {
    return MicrobusCard(
      driverName: bus.driverName,
      model: bus.model,
      color: bus.color,
      plateNumber: bus.plateNumber,
      passengerCount: bus.passengerCount,
      position: bus.position,
      status: bus.status,
      estimatedArrivalMinutes: bus.estimatedArrivalMinutes,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    final bool isOnTheWay = estimatedArrivalMinutes != null;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          /// ================= TOP ROW =================
          Row(
            children: [
              /// الوقت (لو On The Way)
              if (isOnTheWay)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.afterMinutes(estimatedArrivalMinutes!),
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(l10n.arrivalTime, style: theme.textTheme.bodySmall),
                  ],
                ),

              const SizedBox(width: 12),

              /// اسم السواق + التفاصيل
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      driverName,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "$model - $color",
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),

              /// ================= ICONS =================
              Row(
                children: [
                  /// أيقونة الميكروباص
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.directions_bus,
                      color: theme.colorScheme.primary,
                    ),
                  ),

                  const SizedBox(width: 8),

                  /// زرار Report (الجديد)
                  InkWell(
                    borderRadius: BorderRadius.circular(12),

                    //TODO
                    onTap: () async {
                      final cubit = context.read<PassengerCubit>();

                      await cubit.getAllReports(
                        filters: AllrportRequestEntity(
                          plateNumber: plateNumber,
                        ),
                      );

                      final reports = cubit.allReports?.items ?? [];

                      if (reports.isEmpty) {
                        /// ➜ اعمل Report جديد
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                ReportPage(plateNumber: plateNumber),
                          ),
                        );
                      } else {
                        /// ➜ عنده Report بالفعل
                        final reportId = reports.first.id;

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                ReportDetailsPage(reportId: reportId),
                          ),
                        );
                      }

                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (_) => ReportPage(plateNumber: plateNumber),
                      //   ),
                      // );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.report_problem_outlined,
                        color: Colors.red,
                        size: 22,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 16),

          /// ================= BOTTOM =================
          Row(
            children: [
              /// عدد الركاب
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Text(l10n.passengers, style: theme.textTheme.bodySmall),
                      const SizedBox(height: 4),
                      Text(
                        "$passengerCount ${l10n.person}",
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(width: 10),

              /// رقم اللوحة
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Text(l10n.plateNumber, style: theme.textTheme.bodySmall),
                      const SizedBox(height: 4),
                      Text(
                        plateNumber,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _statusText(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    switch (status) {
      case "Loading":
        return l10n.statusLoading;
      case "Ready":
        return l10n.statusReady;
      case "Waiting":
        return l10n.statusWaiting;
      default:
        if (position == 1) return l10n.statusBoarding;
        if (position <= 3) return l10n.statusNear;
        return l10n.statusWaiting;
    }
  }
}
