import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_microbus/features/passener/presentation/cubit/passenger_cubit.dart';
import 'package:smart_microbus/features/passener/presentation/widgets/driver_info_card.dart';
import 'package:smart_microbus/core/helpers/extensions.dart';
import '../../../../core/routing/routes.dart';
import '../../../../l10n/app_localizations.dart';

/// ================= FUNCTION =================
void openAddReportSheet(BuildContext context) {
  final cubit = context.read<PassengerCubit>();

  cubit.resetDriverSearch();

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (_) => const AddReportSheetContent(),
  );
}

/// ================= WIDGET =================
class AddReportSheetContent extends StatelessWidget {
  const AddReportSheetContent({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final cubit = context.read<PassengerCubit>();
    final TextEditingController plateController = TextEditingController();

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: BlocBuilder<PassengerCubit, PassengerState>(
        buildWhen: (previous, current) =>
            current is GetDriverByPlateNumberLoading ||
            current is GetDriverByPlateNumberSuccess ||
            current is GetDriverByPlateNumberError ||
            current is PassengerInitial,

        builder: (context, state) {
          /// ================= LOADING =================
          if (state is GetDriverByPlateNumberLoading) {
            return const Padding(
              padding: EdgeInsets.all(24),
              child: SizedBox(
                height: 150,
                child: Center(child: CircularProgressIndicator()),
              ),
            );
          }

          /// ================= SUCCESS =================
          if (state is GetDriverByPlateNumberSuccess) {
            final driver = state.driver;

            final alreadyReported =
                cubit.allReports?.items.any(
                  (report) => report.plateNumber == driver.plateNumber,
                ) ??
                false;

            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _handle(),

                  /// 🔴 LABEL لو معمول report
                  if (alreadyReported)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        color: Colors.orange.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.warning_amber_rounded,
                            color: Colors.orange,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            l10n.already_reported,
                            style: const TextStyle(
                              color: Colors.orange,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),

                  /// 🚗 الكارد
                  DriverInfoCard(driver: driver),

                  const SizedBox(height: 16),

                  /// 🔘 زرار Report
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: alreadyReported
                          ? null // 🔴 disabled
                          : () {
                              Navigator.pop(context);
                              context.pushNamed(
                                Routes.reportPage,
                                arguments: driver.plateNumber,
                              );
                            },
                      child: Text(l10n.report),
                    ),
                  ),
                ],
              ),
            );
          }

          /// ================= ERROR =================
          if (state is GetDriverByPlateNumberError) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    state.message,
                    style: const TextStyle(color: Colors.red),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        cubit.getDriverByPlate(plateController.text);
                      },
                      child: Text(l10n.retry),
                    ),
                  ),
                ],
              ),
            );
          }

          /// ================= INITIAL =================
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _handle(),

                TextField(
                  controller: plateController,
                  decoration: InputDecoration(
                    labelText: l10n.plate_number,
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.directions_car),
                  ),
                ),

                const SizedBox(height: 16),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (plateController.text.trim().isEmpty) return;

                      cubit.getDriverByPlate(plateController.text.trim());
                    },
                    child: Text(l10n.searchResults),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _handle() {
    return Container(
      width: 40,
      height: 4,
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
