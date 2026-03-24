import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_microbus/core/helpers/show_toast_helper.dart';
import 'package:smart_microbus/features/passener/presentation/cubit/passenger_cubit.dart';
import 'package:smart_microbus/features/passener/presentation/widgets/search_widgets/passenger_search_body.dart';
import 'package:smart_microbus/l10n/app_localizations.dart';

class PassengerSearchView extends StatefulWidget {
  const PassengerSearchView({super.key});

  @override
  State<PassengerSearchView> createState() => _PassengerSearchViewState();
}

class _PassengerSearchViewState extends State<PassengerSearchView> {
  @override
  void initState() {
    super.initState();

    /// 🔥 أول حاجة نجيب المدن
    context.read<PassengerCubit>().getRoutes();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: SafeArea(
        child: BlocConsumer<PassengerCubit, PassengerState>(
          listener: (context, state) {
            if (state is GetRoutesError) {
              ShowToastHelper.showToast(context, state.message);
            }
          },
          builder: (context, state) {
            if (state is GetRoutesLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is GetRoutesError || state is GetDestinationsError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 60,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      state is GetRoutesError
                          ? state.message
                          : (state as GetDestinationsError).message,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        final cubit = context.read<PassengerCubit>();

                        cubit.getRoutes();
                      },
                      child: Text(l10n.retry),
                    ),
                  ],
                ),
              );
            }
            return const PassengerSearchBody();
          },
        ),
      ),
    );
  }
}
