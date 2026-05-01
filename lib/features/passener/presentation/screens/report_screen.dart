import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/helpers/show_toast_helper.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/report_entity.dart';
import '../../domain/entities/report_reason_entity.dart';
import '../../domain/entities/report.dart';
import '../cubit/passenger_cubit.dart';

class ReportPage extends StatefulWidget {
  final String plateNumber;
  final Report? existingReport;

  const ReportPage({super.key, required this.plateNumber, this.existingReport});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  List<int> selectedReasonIds = [];
  List<ReportReasonEntity> reasons = [];
  final TextEditingController descriptionController = TextEditingController();

  bool get isEdit => widget.existingReport != null;

  bool get isOtherSelected =>
      (reasons.isNotEmpty && selectedReasonIds.contains(reasons.last.id) ||
      (isEdit && widget.existingReport!.reasons.contains("other")));

  @override
  void initState() {
    super.initState();

    context.read<PassengerCubit>().getReportReasons();

    if (isEdit) {
      descriptionController.text = widget.existingReport!.description;
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<PassengerCubit>();
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? l10n.editReportTitle : l10n.reportTitle),
      ),
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

                    /// pre-select (edit)
                    if (isEdit && selectedReasonIds.isEmpty) {
                      final existingReasons = widget.existingReport!.reasons;

                      selectedReasonIds = reasons
                          .where((r) => existingReasons.contains(r.name))
                          .map((e) => e.id)
                          .toList();
                    }

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

                                /// ✅ لو شال Other → امسح description
                                if (reason.id == reasons.last.id) {
                                  descriptionController.clear();
                                }
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
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: isOtherSelected
                  ? Column(
                      key: const ValueKey("desc"),
                      children: [
                        TextField(
                          controller: descriptionController,
                          maxLines: 3,
                          decoration: InputDecoration(
                            hintText: l10n.additionalDetailsHint,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                    )
                  : const SizedBox(),
            ),

            /// ================= Submit =================
            BlocConsumer<PassengerCubit, PassengerState>(
              listenWhen: (prev, curr) =>
                  curr is SubmitReportSuccess ||
                  curr is SubmitReportError ||
                  curr is UpdateReportSuccess ||
                  curr is UpdateReportError,
              listener: (context, state) {
                if (state is SubmitReportSuccess ||
                    state is UpdateReportSuccess) {
                  final message = state is SubmitReportSuccess
                      ? state.message
                      : (state as UpdateReportSuccess).message;
                  ShowToastHelper.showToast(context, message);

                  Navigator.pop(context);
                }

                if (state is SubmitReportError || state is UpdateReportError) {
                  final message = state is SubmitReportError
                      ? state.message
                      : (state as UpdateReportError).message;

                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(message)));
                }
              },
              builder: (context, state) {
                final isLoading =
                    state is SubmitReportLoading ||
                    state is UpdateReportLoading;

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

                            /// ✅ validation
                            if (isOtherSelected &&
                                descriptionController.text.trim().isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(l10n.enterDescriptionError),
                                ),
                              );
                              return;
                            }

                            final report = ReportEntity(
                              plateNumber: widget.plateNumber,
                              reasonIds: selectedReasonIds,
                              description: isOtherSelected
                                  ? descriptionController.text
                                  : "",
                            );

                            if (isEdit) {
                              cubit.updateReport(
                                widget.existingReport!.id,
                                report,
                              );
                            } else {
                              cubit.submitReport(report);
                            }
                          },
                    child: isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Text(isEdit ? l10n.updateReport : l10n.submitReport),
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

/// ================= Plate =================
class _PlateWidget extends StatelessWidget {
  final String plate;

  const _PlateWidget({required this.plate});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.plateNumberLabel),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: colors.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(plate, textAlign: TextAlign.center),
        ),
      ],
    );
  }
}

/// ================= Reason Item =================
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
    final colors = Theme.of(context).colorScheme;

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? colors.primary : colors.outlineVariant,
          ),
        ),
        child: Row(
          children: [
            Icon(
              isSelected ? Icons.check_box : Icons.check_box_outline_blank,
              color: isSelected ? colors.primary : colors.onSurfaceVariant,
            ),
            const SizedBox(width: 12),
            Expanded(child: Text(title)),
          ],
        ),
      ),
    );
  }
}
