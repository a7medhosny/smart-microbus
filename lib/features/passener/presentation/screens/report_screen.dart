import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/report_entity.dart';
import '../../domain/entities/report_reason_entity.dart';
import '../cubit/passenger_cubit.dart';

class ReportPage extends StatefulWidget {
  final String plateNumber;

  const ReportPage({super.key, required this.plateNumber});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  List<int> selectedReasonIds = [];
  List<ReportReasonEntity> reasons = [];
  final TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<PassengerCubit>().getReportReasons();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<PassengerCubit>();
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.reportTitle)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// ================= Plate =================
            _PlateWidget(plate: widget.plateNumber),

            const SizedBox(height: 16),

            /// ================= Reasons =================
            Expanded(
              child: BlocBuilder<PassengerCubit, PassengerState>(
                buildWhen: (previous, current) =>
                    current is GetReportReasonsLoading ||
                    current is GetReportReasonsSuccess ||
                    current is GetReportReasonsError,
                builder: (context, state) {
                  if (state is GetReportReasonsLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is GetReportReasonsError) {
                    return Center(child: Text(state.message));
                  }

                  if (state is GetReportReasonsSuccess) {
                    reasons = state.reasons;

                    return ListView.separated(
                      itemCount: reasons.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 10),
                      itemBuilder: (context, index) {
                        final reason = reasons[index];

                        return _ReasonItem(
                          title: reason.name,
                          isSelected: selectedReasonIds.contains(reason.id),
                          onTap: () {
                            setState(() {
                              if (selectedReasonIds.contains(reason.id)) {
                                selectedReasonIds.remove(reason.id);
                              } else {
                                selectedReasonIds.add(reason.id);
                              }
                            });
                          },
                        );
                      },
                    );
                  }

                  return const SizedBox();
                },
              ),
            ),

            /// ================= Description =================
            if (reasons.isNotEmpty &&
                selectedReasonIds.contains(reasons.last.id)) ...[
              TextField(
                controller: descriptionController,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: l10n.additionalDetailsHint,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  contentPadding: const EdgeInsets.all(12),
                ),
              ),
              const SizedBox(height: 16),
            ],

            /// ================= Submit =================
            BlocConsumer<PassengerCubit, PassengerState>(
              listenWhen: (prev, curr) =>
                  curr is SubmitReportSuccess || curr is SubmitReportError,
              listener: (context, state) {
                if (state is SubmitReportSuccess) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(state.message)));
                  Navigator.pop(context);
                }

                if (state is SubmitReportError) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(state.message)));
                }
              },
              buildWhen: (prev, curr) =>
                  curr is SubmitReportLoading ||
                  curr is SubmitReportSuccess ||
                  curr is SubmitReportError,
              builder: (context, state) {
                final isLoading = state is SubmitReportLoading;

                return SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: isLoading
                        ? null
                        : () {
                            if (selectedReasonIds.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(l10n.selectReasonError)),
                              );
                              return;
                            }

                            cubit.submitReport(
                              ReportEntity(
                                plateNumber: widget.plateNumber,
                                reasonIds: selectedReasonIds,
                                description: descriptionController.text,
                              ),
                            );
                          },
                    child: isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Text(l10n.submitReport),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _PlateWidget extends StatelessWidget {
  final String plate;

  const _PlateWidget({required this.plate});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.plateNumberLabel),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(plate, textAlign: TextAlign.center),
        ),
      ],
    );
  }
}

class _ReasonItem extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const _ReasonItem({
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.grey.shade300,
          ),
        ),
        child: Row(
          children: [
            Icon(
              isSelected ? Icons.check_box : Icons.check_box_outline_blank,
              color: isSelected ? Colors.blue : Colors.grey,
            ),
            const SizedBox(width: 12),
            Expanded(child: Text(title)),
          ],
        ),
      ),
    );
  }
}
