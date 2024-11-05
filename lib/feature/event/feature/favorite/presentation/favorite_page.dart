import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_event_manager/feature/event/domain/model/event.dart';
import 'package:flutter_event_manager/feature/event/feature/event_list/presentation/event_card.dart';
import 'package:flutter_event_manager/feature/event/feature/favorite/bloc/favorite_bloc.dart';
import 'package:flutter_event_manager/feature/event/feature/favorite/bloc/favorite_bloc_event.dart';
import 'package:flutter_event_manager/feature/event/feature/favorite/bloc/favorite_bloc_state.dart';
import 'package:flutter_event_manager/navigation/main_router.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return GetIt.instance<FavoriteBloc>();
      },
      child: const _FavoriteContent(),
    );
  }
}

class _FavoriteContent extends StatelessWidget {
  const _FavoriteContent();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<FavoriteBloc>();

    return Scaffold(
      body: BlocBuilder(
          bloc: bloc,
          builder: (context, FavoriteBlocState state) {
            if (state.favorites.isNotEmpty) {
              return _body(
                events: state.favorites,
                onItemTap: (event) {
                  context.push(Destination.routeDetails, extra: event);
                },
                onFavoriteTap: (event) {
                  bloc.add(FavoriteToggleFavorite(event: event));
                },
              );
            } else {
              return _emptyBody();
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push(Destination.routeDetails);
        },
        tooltip: 'Create Event',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _body({
    required List<Event> events,
    required Function(Event) onItemTap,
    required Function(Event) onFavoriteTap,
  }) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 800),
        child: ListView.builder(
          padding: const EdgeInsets.only(bottom: 80),
          itemCount: events.length,
          itemBuilder: (context, index) {
            return EventCard(
              event: events[index],
              onItemTap: onItemTap,
              onFavoriteTap: onFavoriteTap,
            );
          },
        ),
      ),
    );
  }

  Widget _emptyBody() {
    return const Center(
        child: Text('The list is empty. Add event to favorites.'));
  }
}
