import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_microbus/core/helpers/extensions.dart';
import 'package:smart_microbus/core/helpers/show_toast_helper.dart';
import 'package:smart_microbus/features/passener/presentation/cubit/nav_cubit.dart';
import 'package:smart_microbus/features/passener/presentation/cubit/passenger_cubit.dart';
import 'package:smart_microbus/features/passener/presentation/widgets/search_widgets/passenger_search_body.dart';
import 'package:smart_microbus/l10n/app_localizations.dart';

import '../../../../core/routing/routes.dart';

class PassengerSearchView extends StatefulWidget {
  const PassengerSearchView({super.key});

  @override
  State<PassengerSearchView> createState() => _PassengerSearchViewState();
}

class _PassengerSearchViewState extends State<PassengerSearchView> {
  @override
  void initState() {
    super.initState();

    final cubit = context.read<PassengerCubit>();
    cubit.getRoutes();
    cubit.getFavorites();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: const SafeArea(
        child: Column(
          children: [
            ///  Routes Section
            Expanded(child: _RoutesSection()),

            ///  Favorites Section
            _FavouriteSection(),
          ],
        ),
      ),
    );
  }
}

////////////////////////////////////////////////////////////
///  ROUTES SECTION
////////////////////////////////////////////////////////////

class _RoutesSection extends StatelessWidget {
  const _RoutesSection();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PassengerCubit, PassengerState>(
      listenWhen: (prev, curr) =>
          curr is GetRoutesError || curr is GetFavoritesError,
      listener: (context, state) {
        if (state is GetRoutesError) {
          ShowToastHelper.showToast(context, state.message);
        } else if (state is GetFavoritesError) {
          ShowToastHelper.showToast(context, state.message);
        }
      },
      buildWhen: (prev, curr) =>
          curr is GetRoutesLoading ||
          curr is GetRoutesSuccess ||
          curr is GetRoutesError,
      builder: (context, state) {
        /// ===== LOADING =====
        if (state is GetRoutesLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        /// ===== ERROR =====
        if (state is GetRoutesError) {
          return _ErrorWidget(
            message: state.message,
            onRetry: () {
              context.read<PassengerCubit>().getRoutes();
            },
          );
        }

        /// ===== SUCCESS =====
        return const PassengerSearchBody();
      },
    );
  }
}

////////////////////////////////////////////////////////////
///  FAVOURITES SECTION
////////////////////////////////////////////////////////////

class _FavouriteSection extends StatelessWidget {
  const _FavouriteSection();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<PassengerCubit>();
    final navCubit = context.read<NavCubit>();

    final l10n = AppLocalizations.of(context)!;

    return BlocBuilder<PassengerCubit, PassengerState>(
      buildWhen: (prev, curr) =>
          curr is GetFavoritesLoading ||
          curr is GetFavoritesSuccess ||
          curr is GetFavoritesError,
      builder: (context, state) {
        /// ===== LOADING =====
        if (state is GetFavoritesLoading) {
          return const Padding(
            padding: EdgeInsets.all(16),
            child: CircularProgressIndicator(),
          );
        }

        /// ===== ERROR (silent) =====
        if (state is GetFavoritesError) {
          return const SizedBox();
        }

        final favs = cubit.favouriteRoutes;

        if (favs.isEmpty) return const SizedBox();

        final preview = favs.take(2).toList();

        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              /// ===== Header =====
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    l10n.favoritesTitle,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      navCubit.changeIndex(1);
                    },
                    child: Text(l10n.seeAll),
                  ),
                ],
              ),

              /// ===== List =====
              ...preview.map(
                (fav) => InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () {
                    final cubit = context.read<PassengerCubit>();

                    cubit.getAllRouteData(fav.routeId);

                    context.pushNamed(Routes.passengerSearchResultScreen);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey.withOpacity(0.1),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.history),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            "${fav.from} → ${fav.to}",
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

////////////////////////////////////////////////////////////
///  ERROR WIDGET
////////////////////////////////////////////////////////////

class _ErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorWidget({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 60, color: Colors.red),
          const SizedBox(height: 16),
          Text(message, textAlign: TextAlign.center),
          const SizedBox(height: 20),
          ElevatedButton(onPressed: onRetry, child: Text(l10n.retry)),
        ],
      ),
    );
  }
}
