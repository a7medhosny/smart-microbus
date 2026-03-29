import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_microbus/features/passener/presentation/screens/report_screen.dart';

import '../../../../core/helpers/show_toast_helper.dart';
import '../../../../l10n/app_localizations.dart';
import '../cubit/passenger_cubit.dart';

class ReportDetailsPage extends StatefulWidget {
  final String reportId;

  const ReportDetailsPage({super.key, required this.reportId});

  @override
  State<ReportDetailsPage> createState() => _ReportDetailsPageState();
}

class _ReportDetailsPageState extends State<ReportDetailsPage> {
  @override
  void initState() {
    super.initState();
    context.read<PassengerCubit>().getReportById(widget.reportId);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final textTheme = theme.textTheme;
    final cubit = context.read<PassengerCubit>();
    final l10n = AppLocalizations.of(context)!;

    return BlocConsumer<PassengerCubit, PassengerState>(
      listenWhen: (prev, curr) =>
          curr is DeleteReportSuccess ||
          curr is DeleteReportError ||
          curr is UpdateReportSuccess ||
          curr is UpdateReportError,
      listener: (context, state) {
        /// ================= SUCCESS =================
        if (state is DeleteReportSuccess) {
          final message = state.message;

          ShowToastHelper.showToast(context, message);

          Navigator.pop(context);
        }

        /// ================= ERROR =================
        if (state is DeleteReportError || state is UpdateReportError) {
          final message = state is DeleteReportError
              ? state.message
              : (state as UpdateReportError).message;

          ShowToastHelper.showToast(
            context,
            message,
            backgroundColor: colors.error,
          );
        }
      },
      buildWhen: (prev, curr) =>
          curr is GetReportByIdLoading ||
          curr is GetReportByIdSuccess ||
          curr is GetReportByIdError ||
          curr is DeleteReportLoading ||
          curr is UpdateReportLoading,
      builder: (context, state) {
        final isLoading =
            state is DeleteReportLoading || state is UpdateReportLoading;

        return Scaffold(
          appBar: AppBar(title: Text(l10n.reportDetails), centerTitle: true),
          body: Builder(
            builder: (context) {
              /// ================= LOADING =================
              if (state is GetReportByIdLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              /// ================= ERROR =================
              if (state is GetReportByIdError) {
                return Center(
                  child: Text(
                    state.message,
                    style: textTheme.bodyMedium?.copyWith(color: colors.error),
                  ),
                );
              }

              /// ================= SUCCESS =================
              if (state is GetReportByIdSuccess) {
                final report = state.report;

                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      /// CARD
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: colors.surface,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: colors.shadow.withOpacity(0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildRow(
                              context,
                              title: l10n.plateNumber,
                              value: report.plateNumber,
                            ),
                            const SizedBox(height: 12),
                            _buildRow(
                              context,
                              title: l10n.status,
                              value: report.status,
                            ),

                            if (report.description.isNotEmpty) ...[
                              const SizedBox(height: 12),
                              _buildRow(
                                context,
                                title: l10n.description,
                                value: report.description,
                              ),
                            ],

                            const SizedBox(height: 16),

                            /// REASONS
                            if (report.reasons.isNotEmpty) ...[
                              Text(
                                l10n.reasons,
                                style: textTheme.labelMedium?.copyWith(
                                  color: colors.onSurfaceVariant,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: report.reasons
                                    .map(
                                      (reason) => Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 6,
                                        ),
                                        decoration: BoxDecoration(
                                          color: colors.secondaryContainer,
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                        ),
                                        child: Text(
                                          reason,
                                          style: textTheme.bodyMedium?.copyWith(
                                            color: colors.onSecondaryContainer,
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ],
                          ],
                        ),
                      ),

                      const Spacer(),

                      /// ACTIONS
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton.icon(
                              icon: isLoading
                                  ? const SizedBox(
                                      height: 16,
                                      width: 16,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : Icon(Icons.delete, color: colors.error),
                              label: Text(
                                l10n.delete,
                                style: TextStyle(color: colors.error),
                              ),
                              onPressed: isLoading
                                  ? null
                                  : () {
                                      _showDeleteDialog(
                                        context,
                                        cubit,
                                        report.id,
                                      );
                                    },
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton.icon(
                              icon: const Icon(Icons.edit),
                              label: Text(l10n.edit),
                              onPressed: isLoading
                                  ? null
                                  : () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => ReportPage(
                                            plateNumber: report.plateNumber,
                                            existingReport: report,
                                          ),
                                        ),
                                      );
                                    },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }

              return const SizedBox();
            },
          ),
        );
      },
    );
  }

  Widget _buildRow(
    BuildContext context, {
    required String title,
    required String value,
  }) {
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: textTheme.labelMedium?.copyWith(
            color: colors.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  void _showDeleteDialog(
    BuildContext context,
    PassengerCubit cubit,
    String id,
  ) {
    final l10n = AppLocalizations.of(context)!;

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.deleteReport),
        content: Text(l10n.deleteConfirmation),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              cubit.deleteReport(id);
            },
            child: Text(l10n.delete),
          ),
        ],
      ),
    );
  }
}
