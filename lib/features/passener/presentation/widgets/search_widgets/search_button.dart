import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_microbus/core/routing/routes.dart';
import 'package:smart_microbus/features/passener/presentation/cubit/passenger_cubit.dart';
import 'package:smart_microbus/l10n/app_localizations.dart';

import '../../../../../core/helpers/show_toast_helper.dart';

class SearchButton extends StatelessWidget {
  const SearchButton({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () {
          final cubit = context.read<PassengerCubit>();
          final routeId = cubit.selectedRouteId;

          if (routeId == null) {
            ShowToastHelper.showToast(
              context,
              l10n.pleaseSelectARoute,
              backgroundColor: Colors.red,
            );
            return;
          }

          cubit.getAllRouteData(routeId);
          Navigator.pushNamed(context, Routes.passengerSearchResultScreen);
        },
        icon: const Icon(Icons.search),
        label: Text(l10n.searchTrips),
      ),
    );
  }
}
