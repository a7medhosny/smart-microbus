import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:smart_microbus/l10n/app_localizations.dart';

import '../../cubit/map_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({super.key});

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  @override
  Widget build(BuildContext context) {
    final controller = context.read<MapCubit>().controller;
    final colorScheme = Theme.of(context).colorScheme;
    final loc = AppLocalizations.of(context)!;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      child: TextField(
        controller: controller,

        onChanged: (value) {
          context.read<MapCubit>().updateSearchQuery(value);
        },

        style: TextStyle(fontSize: 14.sp),

        decoration: InputDecoration(
          hintText: loc.searchHere,

          prefixIcon: Icon(Icons.search, color: colorScheme.primary),

          suffixIcon: IconButton(
            icon: Icon(Icons.close, size: 16.sp),
            onPressed: () {
              controller.clear();

              context.read<MapCubit>().updateSearchQuery("");

              FocusScope.of(context).unfocus();
            },
          ),

          filled: true,
          fillColor: colorScheme.surface,

          contentPadding: EdgeInsets.symmetric(vertical: 12.h),

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.r),
            borderSide: BorderSide.none,
          ),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.r),
            borderSide: BorderSide.none,
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.r),
            borderSide: BorderSide(
              color: colorScheme.primary.withOpacity(0.4),
              width: 1.2,
            ),
          ),
        ),
      ),
    );
  }
}
