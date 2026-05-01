import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InfoChip extends StatelessWidget {
  final String text;

  const InfoChip({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: colorScheme.primary.withOpacity(.12),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(text, style: textTheme.bodyMedium),
    );
  }
}
