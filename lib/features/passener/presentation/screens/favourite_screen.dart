import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:smart_microbus/features/passener/domain/entities/favourite_route_entity.dart';
import 'package:smart_microbus/features/passener/presentation/cubit/passenger_cubit.dart';
import 'package:smart_microbus/l10n/app_localizations.dart';

import '../../../../core/helpers/app_error_helper.dart';
import '../../../../core/widgets/empty_list.dart';
import '../widgets/favourite_route_card.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  void initState() {
    super.initState();
    // context.read<PassengerCubit>().getFavorites();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(title: Text(l10n.favoritesTitle), centerTitle: true),
      body: BlocBuilder<PassengerCubit, PassengerState>(
        buildWhen: (previous, current) {
          return current is GetFavoritesLoading ||
              current is GetFavoritesSuccess ||
              current is GetFavoritesError;
        },
        builder: (context, state) {
          print("UI STATE: $state");
          final cubit = context.read<PassengerCubit>();

          /// ⏳ Loading
          if (state is GetFavoritesLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          /// ❌ Error
          if (state is GetFavoritesError) {
            AppErrorWidget(
              message: state.message,
              onRetry: () {
                context.read<PassengerCubit>().getFavorites();
              },
            );
          }

          final List<FavouriteRouteEntity> favs = cubit.favouriteRoutes;

          /// 📭 Empty
          if (favs.isEmpty) {
            return EmptyList(
              title: l10n.noFavorites,
              message: l10n.noFavoritesMessage,
              icon: Icons.favorite_border,
            );
          }

          /// ✅ List
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: favs.length,
            itemBuilder: (context, index) {
              final item = favs[index];

              return FavouriteRouteCard(
                route: item,
                onRemove: () {
                  context.read<PassengerCubit>().removeFromFavorites(
                    item.routeId,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
