import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_microbus/features/passener/presentation/cubit/passenger_cubit.dart';
import 'package:smart_microbus/features/passener/presentation/widgets/report_widgets/driver_info_card.dart';
import 'package:smart_microbus/core/helpers/extensions.dart';
import '../../../../../core/routing/routes.dart';
import '../../../../../l10n/app_localizations.dart';
import 'plate_input_field.dart';

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
    builder: (_) => AddReportSheetContent(),
  );
}

/// ================= WIDGET =================
class AddReportSheetContent extends StatelessWidget {
  AddReportSheetContent({super.key});
  final letter1Controller = TextEditingController();
  final letter2Controller = TextEditingController();
  final numbersController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final cubit = context.read<PassengerCubit>();

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
          // if (state is GetDriverByPlateNumberError) {
          //   return Padding(
          //     padding: const EdgeInsets.all(16),
          //     child: Column(
          //       mainAxisSize: MainAxisSize.min,
          //       children: [
          //         Text(
          //           state.message,
          //           style: const TextStyle(color: Colors.red),
          //         ),
          //         const SizedBox(height: 10),
          //         SizedBox(
          //           width: double.infinity,
          //           child: ElevatedButton(
          //             onPressed: () {
          //               cubit.getDriverByPlate(plateController.text);
          //             },
          //             child: Text(l10n.retry),
          //           ),
          //         ),
          //       ],
          //     ),
          //   );
          // }

          /// ================= INITIAL + ERROR =================
          final isError = state is GetDriverByPlateNumberError;
          final errorMessage = isError ? (state).message : null;

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _handle(),

                /// 🔴 رسالة الخطأ
                if (isError)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.error_outline, color: Colors.red),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            errorMessage ?? '',
                            style: const TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                /// 🔤 input
                PlateInputField(
                  letter1Controller: letter1Controller,
                  letter2Controller: letter2Controller,
                  numbersController: numbersController,
                ),

                const SizedBox(height: 16),

                /// 🔘 زرار البحث
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      final plate =
                         "${letter1Controller.text} ${letter2Controller.text} ${numbersController.text}"
                              .trim();

                      if (plate.length < 5) return;

                      cubit.getDriverByPlate(plate);
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
