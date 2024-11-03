import 'package:flutter/material.dart';
import 'package:flutter_event_manager/core/bloc/bloc_provider.dart';
import 'package:flutter_event_manager/feature/event_list/presentation/event_card.dart';
import 'package:flutter_event_manager/feature/favorite/bloc/favorite_bloc.dart';
import 'package:flutter_event_manager/feature/favorite/bloc/favorite_bloc_event.dart';
import 'package:flutter_event_manager/navigation/main_router.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: () => GetIt.instance.get<FavoriteBloc>(),
      child: const _FavoritePage(),
    );
  }
}

class _FavoritePage extends StatelessWidget {
  const _FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    var bloc = context.read<FavoriteBloc>();

    return StreamBuilder(
      stream: bloc.outState,
      builder: (context, snapshot) {
        var state = snapshot.data;
        debugPrint("stream ${snapshot.data}");

        if (state != null && state.favorites.isNotEmpty) {
          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800), //todo
              child: ListView.builder(
                itemCount: state.favorites.length,
                itemBuilder: (context, index) {
                  return EventCard(
                    event: state.favorites[index],
                    onItemTap: (event) {
                      context.push(Destination.routeDetails, extra: event);
                    },
                    onFavoriteTap: (event) {
                      bloc.inEvent.add(
                        FavoriteBlocEvent.toggleFavorite(event: event),
                      );
                    },
                  );
                },
              ),
            ),
          );
        } else {
          return const Center(child: Text('The list is empty. Add event to favorites.')); // todo
        }
      },
    );
  }
}
