import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_microbus/l10n/app_localizations.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final loc = AppLocalizations.of(context)!;

    return Container(
      height: 58.h,
      margin: EdgeInsets.symmetric(horizontal: 14.w),
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: Row(
        children: [
          Icon(Icons.search, color: colorScheme.onSurfaceVariant),

          SizedBox(width: 12.w),

          Expanded(
            child: Text(
              loc.searchHere,
              style: textTheme.bodyLarge?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ),

          // Icon(
          //   Icons.mic,
          //   color: colorScheme.onSurfaceVariant,
          // ),

          // SizedBox(width: 14.w),

          // CircleAvatar(
          //   radius: 18.r,
          //   backgroundColor: colorScheme.primary,
          //   child: Icon(
          //     Icons.person_outline,
          //     color: colorScheme.onPrimary,
          //   ),
          // ),
        ],
      ),
    );
  }
}
