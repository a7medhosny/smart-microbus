import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_microbus/features/passener/domain/entities/report_item_entity.dart';

import '../../../../../l10n/app_localizations.dart';

class ReportCardMini extends StatelessWidget {
  final ReportItemEntity report;
  final VoidCallback onTap;

  const ReportCardMini({super.key, required this.report, required this.onTap});

  String formatDate(String date) {
    try {
      final parsed = DateTime.parse(date);
      return DateFormat('dd MMM yyyy').format(parsed);
    } catch (_) {
      return date;
    }
  }

  Color getStatusColor(ColorScheme colors) {
    switch (report.status.toLowerCase()) {
      case "pending":
        return Colors.orange;
      case "reviewed":
        return Colors.green;
      default:
        return colors.primary;
    }
  }

  String getStatusText(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    switch (report.status.toLowerCase()) {
      case "pending":
        return l10n.pending;
      case "reviewed":
        return l10n.approved;

      default:
        return l10n.pending;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final statusColor = getStatusColor(colors);
    print("🟢 status = ${report.status}");
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: colors.outline.withOpacity(0.08)),
          boxShadow: [
            BoxShadow(
              color: colors.shadow.withOpacity(0.06),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            /// Icon
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.description_rounded,
                color: statusColor,
                size: 22,
              ),
            ),

            const SizedBox(width: 14),

            /// Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Plate Number
                  Text(
                    report.plateNumber,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: colors.onSurface,
                    ),
                  ),

                  const SizedBox(height: 6),

                  /// Date
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today_outlined,
                        size: 14,
                        color: colors.onSurfaceVariant,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        formatDate(report.createdAt),
                        style: TextStyle(
                          color: colors.onSurfaceVariant,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            /// Status Chip
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.12),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                getStatusText(context),
                style: TextStyle(
                  color: statusColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
