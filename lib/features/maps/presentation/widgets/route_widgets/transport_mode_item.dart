import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TransportModeItem extends StatelessWidget {
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  const TransportModeItem({
    super.key,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 72.w,
        height: 52.h,
        decoration: BoxDecoration(
          color: selected
              ? colorScheme.primary.withOpacity(.18)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(30.r),
        ),
        child: Icon(
          icon,
          color: selected
              ? colorScheme.primary
              : colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}