import 'package:flutter/material.dart';
import '../../cubit/driver_home_cubit.dart';

class DateFilterInfo extends StatelessWidget {
  final DriverHomeCubit cubit;

  const DateFilterInfo({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    if (cubit.tripFromDate == null || cubit.tripToDate == null) {
      return const SizedBox();
    }

    final theme = Theme.of(context);
    final from = cubit.tripFromDate!;
    final to = cubit.tripToDate!;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withOpacity(.08),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(
            Icons.calendar_today,
            size: 18,
            color: theme.colorScheme.primary,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              "${from.day}/${from.month} - ${to.day}/${to.month}",
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          GestureDetector(
            onTap: () => cubit.clearTripFilter(),
            child: const Icon(Icons.close, size: 18),
          ),
        ],
      ),
    );
  }
}
