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
        if (state is DeleteReportSuccess) {
          ShowToastHelper.showToast(context, state.message);
          Navigator.pop(context);
        }

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
              if (state is GetReportByIdLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is GetReportByIdError) {
                return Center(
                  child: Text(
                    state.message,
                    style: textTheme.bodyMedium?.copyWith(
                      color: colors.error,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              }

              if (state is GetReportByIdSuccess) {
                final report = state.report;
                String getStatusText() {
                  final l10n = AppLocalizations.of(context)!;
                  switch (report.status.toLowerCase()) {
                    case "pending":
                      return l10n.pending;
                    case "approved":
                      return l10n.approved;
                    case "rejected":
                      return l10n.rejected;
                    default:
                      return l10n.pending;
                  }
                }

                return SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      /// CARD
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 20,
                        ),
                        decoration: BoxDecoration(
                          color: colors.surface,
                          borderRadius: BorderRadius.circular(22),
                          border: Border.all(
                            color: colors.outline.withOpacity(0.1),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: colors.shadow.withOpacity(0.08),
                              blurRadius: 24,
                              offset: const Offset(0, 12),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// TOP ACCENT
                            Container(
                              height: 4,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                gradient: LinearGradient(
                                  colors: [colors.primary, colors.secondary],
                                ),
                              ),
                            ),

                            const SizedBox(height: 20),

                            /// PLATE NUMBER
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 16,
                              ),
                              decoration: BoxDecoration(
                                color: colors.surface.withOpacity(0.6),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: colors.primary.withOpacity(0.2),
                                ),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    l10n.plateNumber,
                                    style: textTheme.labelSmall?.copyWith(
                                      color: colors.onSurfaceVariant,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    report.plateNumber,
                                    style: textTheme.titleLarge?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.3,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 20),

                            _buildRow(
                              context,
                              title: l10n.status,
                              value: getStatusText(),
                              isStatus: true,
                            ),

                            if (report.description.isNotEmpty) ...[
                              const SizedBox(height: 20),
                              _buildRow(
                                context,
                                title: l10n.description,
                                value: report.description,
                              ),
                            ],

                            const SizedBox(height: 24),

                            /// REASONS
                            if (report.reasons.isNotEmpty) ...[
                              Text(
                                l10n.reasons,
                                style: textTheme.labelMedium?.copyWith(
                                  color: colors.onSurfaceVariant,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Wrap(
                                spacing: 10,
                                runSpacing: 10,
                                children: report.reasons.map((reason) {
                                  return Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 14,
                                      vertical: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          colors.secondary.withOpacity(0.2),
                                          colors.secondary.withOpacity(0.05),
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(14),
                                      border: Border.all(
                                        color: colors.secondary.withOpacity(
                                          0.25,
                                        ),
                                      ),
                                    ),
                                    child: Text(
                                      reason,
                                      style: textTheme.bodyMedium?.copyWith(
                                        color: colors.secondary,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ],
                          ],
                        ),
                      ),

                      const SizedBox(height: 30),

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
                                style: TextStyle(
                                  color: colors.error,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
                                side: BorderSide(color: colors.error),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
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
                              label: Text(
                                l10n.edit,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                elevation: 2,
                              ),
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

                      const SizedBox(height: 20),
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
    bool isStatus = false,
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
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 6),
        isStatus
            ? Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      colors.primary.withOpacity(0.15),
                      colors.primary.withOpacity(0.05),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  value,
                  style: textTheme.bodyMedium?.copyWith(
                    color: colors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
            : Text(
                value,
                style: textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
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
            child: Text(
              l10n.delete,
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ),
        ],
      ),
    );
  }
}
