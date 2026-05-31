import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_microbus/core/helpers/show_toast_helper.dart';
import 'package:smart_microbus/features/passener/presentation/cubit/passenger_cubit.dart';
import 'package:smart_microbus/features/passener/presentation/widgets/search_widgets/passenger_search_body.dart';
import 'package:smart_microbus/l10n/app_localizations.dart';

import '../../../../core/auth/guest_guard.dart';
import '../../../../core/helpers/app_error_helper.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/storage/cache_helper.dart';
import '../../../../core/storage/cache_keys.dart';

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

    if (GuestGuard.canAccess(GuestFeature.getFavouriteRoutes)) {
      cubit.getFavorites();
    }
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
      listenWhen: (prev, curr) => curr is GetRoutesError,
      listener: (context, state) {
        if (state is GetRoutesError) {
          ShowToastHelper.showToast(
            context,
            state.message,
            backgroundColor: Colors.red,
            icon: Icons.error,
          );
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
          return AppErrorWidget(
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
    final lang = CacheHelper.getCacheData(key: CacheKeys.localeKey) ?? 'en';
    final isArabic = lang == 'ar';
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
                      cubit.changeBottomNavIndex(1);
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

                    cubit.currentNavigatorKey.currentState?.pushNamed(
                      Routes.passengerSearchResultScreen,
                      arguments: fav.routeId,
                    );
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
                            isArabic
                                ? "${fav.from} ← ${fav.to}" //  عكس الاتجاه
                                : "${fav.from} → ${fav.to}", //  الطبيعي
                            style: const TextStyle(fontSize: 14),
                            textAlign: isArabic
                                ? TextAlign.right
                                : TextAlign.left,
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
