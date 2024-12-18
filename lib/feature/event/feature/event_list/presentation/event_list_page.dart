import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_event_manager/feature/event/domain/model/event.dart';
import 'package:flutter_event_manager/feature/event/feature/event_list/bloc/event_list_bloc.dart';
import 'package:flutter_event_manager/feature/event/feature/event_list/bloc/event_list_bloc_event.dart';
import 'package:flutter_event_manager/feature/event/feature/event_list/bloc/event_list_bloc_state.dart';
import 'package:flutter_event_manager/feature/event/feature/event_list/presentation/event_card.dart';
import 'package:flutter_event_manager/navigation/main_router.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class EventListPage extends StatelessWidget {
  const EventListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return GetIt.instance<EventListBloc>();
      },
      child: const _EventListContent(),
    );
  }
}

class _EventListContent extends StatelessWidget {
  const _EventListContent();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<EventListBloc>();

    return Scaffold(
      body: BlocBuilder(
          bloc: bloc,
          builder: (context, EventListBlocState state) {
            if (state.eventList.isNotEmpty) {
              return _body(events: state.eventList,
                onItemTap: (event) {
                  context.push(Destination.routeDetails, extra: event);
                },
                onFavoriteTap: (event) {
                  bloc.add(EventListToggleFavorite(event: event));
                },);
            } else {
              return _emptyBody();
            }
          }
      ),
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
    return const Center(child: Text('The list is empty.'));
  }
}
