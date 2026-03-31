import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_microbus/core/helpers/app_error_helper.dart';
import 'package:smart_microbus/core/helpers/extensions.dart';
import 'package:smart_microbus/core/widgets/empty_list.dart';
import 'package:smart_microbus/l10n/app_localizations.dart';
import '../../../../core/routing/routes.dart';
import '../../domain/entities/all_report_request_entity.dart';
import '../cubit/passenger_cubit.dart';
import '../widgets/report_card_mini.dart';

import 'report_details_screen.dart';

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
    context.read<PassengerCubit>().getAllReports(
      filters: AllrportRequestEntity(
        plateNumber: plateController.text.isEmpty ? null : plateController.text,
        fromDate: fromDate,
        toDate: toDate,
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
    final tempPlate = TextEditingController(text: plateController.text);
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
                    TextField(
                      controller: tempPlate,
                      decoration: InputDecoration(
                        labelText: tr.plate_number,
                        prefixIcon: Icon(Icons.directions_car),
                        border: OutlineInputBorder(),
                      ),
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
                                plateController.text = tempPlate.text;
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
                                tempPlate.clear();
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
        ],
      ),
    );
  }
}
