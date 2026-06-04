import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_microbus/core/helpers/app_error_helper.dart';
import 'package:smart_microbus/core/helpers/extensions.dart';
import 'package:smart_microbus/core/widgets/empty_list.dart';
import 'package:smart_microbus/l10n/app_localizations.dart';
import '../../../../core/routing/routes.dart';
import '../../domain/entities/all_report_request_entity.dart';
import '../cubit/passenger_cubit.dart';
import '../widgets/report_widgets/add_report_sheet.dart';
import '../widgets/report_widgets/plate_input_field.dart';
import '../widgets/report_widgets/report_card_mini.dart';

class AllReportScreen extends StatefulWidget {
  const AllReportScreen({super.key});

  @override
  State<AllReportScreen> createState() => _AllReportScreenState();
}

class _AllReportScreenState extends State<AllReportScreen> {
  final TextEditingController plateController = TextEditingController();

  DateTime? fromDate;
  DateTime? toDate;

  @override
  void initState() {
    super.initState();
    context.read<PassengerCubit>().getAllReports();
  }

  void applyFilter() {
    final fixedToDate = toDate == null
        ? null
        : DateTime(toDate!.year, toDate!.month, toDate!.day, 23, 59, 59);
    context.read<PassengerCubit>().getAllReports(
      filters: AllrportRequestEntity(
        plateNumber: plateController.text.isEmpty ? null : plateController.text,
        fromDate: fromDate,
        toDate: fixedToDate,
        pageNumber: 1,
        pageSize: 10,
      ),
    );
  }

  void resetFilter() {
    plateController.clear();
    fromDate = null;
    toDate = null;

    context.read<PassengerCubit>().getAllReports();
    setState(() {});
  }

  Future<void> pickDate(bool isFrom) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        if (isFrom) {
          fromDate = picked;
        } else {
          toDate = picked;
        }
      });
    }
  }

  void _openFilterSheet() {
    final tr = AppLocalizations.of(context)!;
    final letter1Controller = TextEditingController();
    final letter2Controller = TextEditingController();
    final letter3Controller = TextEditingController();
    final numbersController = TextEditingController();

  //     String getPlate() {
  //   return [
  //     letter1Controller.text.trim(),
  //     letter2Controller.text.trim(),
  //     letter3Controller.text.trim(),
  //     numbersController.text.trim(),
  //   ].where((e) => e.isNotEmpty).join(' ');
  // }

    if (plateController.text.isNotEmpty && plateController.text.length >= 3) {
      final plate = plateController.text;

      letter1Controller.text = plate[0];
      letter2Controller.text = plate[2];
      numbersController.text = plate.substring(3);
    }
    DateTime? tempFrom = fromDate;
    DateTime? tempTo = toDate;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: StatefulBuilder(
            builder: (context, setModalState) {
              return Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    /// Handle
                    Container(
                      width: 40,
                      height: 4,
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),

                    /// Title
                    Text(
                      tr.filter_reports,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 16),

                    /// Plate
                    PlateInputField(
                      label: tr.plate_number,
                      letter1Controller: letter1Controller,
                      letter2Controller: letter2Controller,
                      letter3Controller: letter3Controller,
                      numbersController: numbersController,
                    ),

                    const SizedBox(height: 16),

                    /// Dates
                    Row(
                      children: [
                        Expanded(
                          child: _modalDateBox(tr.from, tempFrom, () async {
                            final picked = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2020),
                              lastDate: DateTime.now(),
                            );
                            if (picked != null) {
                              setModalState(() => tempFrom = picked);
                            }
                          }),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _modalDateBox(tr.to, tempTo, () async {
                            final picked = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2020),
                              lastDate: DateTime.now(),
                            );
                            if (picked != null) {
                              setModalState(() => tempTo = picked);
                            }
                          }),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    /// Buttons
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                final plate =
                                   getPlate(
                                      letter1Controller: letter1Controller,
                                      letter2Controller: letter2Controller,
                                      letter3Controller: letter3Controller,
                                      numbersController: numbersController,
                                   );

                                plateController.text = plate;
                                fromDate = tempFrom;
                                toDate = tempTo;
                              });

                              applyFilter();
                              Navigator.pop(context);
                            },
                            child: Text(tr.apply),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              setModalState(() {
                                letter1Controller.clear();
                                letter2Controller.clear();
                                numbersController.clear();
                                tempFrom = null;
                                tempTo = null;
                              });
                            },
                            child: Text(tr.reset),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _modalDateBox(String title, DateTime? date, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          border: Border.all(color: Theme.of(context).dividerColor),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          date == null ? title : date.toString().split(" ").first,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context)!;
    final cubit = context.read<PassengerCubit>();

    return Scaffold(
      appBar: AppBar(
        title: Text(tr.all_reports_title),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_alt),
            onPressed: _openFilterSheet,
          ),
        ],
      ),
      body: Column(
        children: [
          /// LIST
          Expanded(
            child: BlocBuilder<PassengerCubit, PassengerState>(
              buildWhen: (previous, current) =>
                  current is GetAllReportsLoading ||
                  current is GetAllReportsSuccess ||
                  current is GetAllReportsError,
              builder: (context, state) {
                if (state is GetAllReportsLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is GetAllReportsError) {
                  return AppErrorWidget(
                    message: state.message,
                    onRetry: () =>
                        context.read<PassengerCubit>().getAllReports(),
                  );
                }

                if (state is GetAllReportsSuccess) {
                  final reports = state.data;

                  if (reports.items.isEmpty) {
                    return EmptyList(
                      title: tr.reports_empty_title,
                      message: tr.reports_empty_message,
                      icon: Icons.report_outlined,
                    );
                  }

                  return ListView.builder(
                    // padding: const EdgeInsets.only(
                    //   bottom: 80,
                    // ), // مهم عشان الزرار
                    itemCount: reports.items.length,
                    itemBuilder: (context, index) {
                      final report = reports.items[index];

                      return ReportCardMini(
                        report: report,
                        onTap: () {
                          context.pushNamed(
                            Routes.reportDetailsPage,
                            arguments: report.id,
                          );
                        },
                      );
                    },
                  );
                }

                return const SizedBox();
              },
            ),
          ),

          // /// BUTTON (بدل الفلوتنج)
          // SafeArea(
          //   child: Padding(
          //     padding: const EdgeInsets.all(16),
          //     child: SizedBox(
          //       width: double.infinity,
          //       child: ElevatedButton.icon(
          //         onPressed: () => openAddReportSheet(context),
          //         icon: const Icon(Icons.report),
          //         label: Text("الإبلاغ عن سائق"), // "الإبلاغ عن سائق"
          //         style: ElevatedButton.styleFrom(
          //           padding: const EdgeInsets.symmetric(vertical: 14),
          //           textStyle: const TextStyle(fontSize: 16),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => openAddReportSheet(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
