import 'package:flutter/material.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/station_microbus_entity.dart';

class DriverInfoCard extends StatelessWidget {
  final StationMicrobusEntity driver;

  const DriverInfoCard({super.key, required this.driver});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tr = AppLocalizations.of(context)!;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 🚗 ICON
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: theme.primaryColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.directions_bus, color: theme.primaryColor),
            ),

            const SizedBox(width: 16),

            /// 📄 INFO
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Plate Number (مهم دايمًا يظهر)
                  Text(
                    driver.plateNumber.trim().isEmpty
                        ? "-"
                        : driver.plateNumber,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  /// باقي البيانات (تظهر بس لو فيها قيمة)
                  ..._buildInfoRows(tr, driver),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 🔥 يبني الليست ديناميك
  List<Widget> _buildInfoRows(
    AppLocalizations tr,
    StationMicrobusEntity driver,
  ) {
    final List<Widget> rows = [];

    void addRow(String label, String? value) {
      if (value != null && value.trim().isNotEmpty) {
        rows.add(_infoRow(label, value));
      }
    }

    addRow(tr.driver, driver.driverName);
    addRow(tr.model, driver.model);
    addRow(tr.color, driver.color);

    if (driver.passengerCount != null) {
      rows.add(_infoRow(tr.passengers, driver.passengerCount.toString()));
    }

    return rows;
  }

  /// 🔹 reusable row
  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text("$label: $value", style: const TextStyle(fontSize: 13)),
    );
  }
}
