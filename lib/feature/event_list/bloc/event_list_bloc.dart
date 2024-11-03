import 'package:flutter_event_manager/core/bloc/bloc_base.dart';
import 'package:flutter_event_manager/feature/event_list/domain/event_repository.dart';

import 'event_list_bloc_event.dart';
import 'event_list_bloc_state.dart';

class EventListBloc
    extends BlocBase<EventListBlocState, Never, EventListBlocEvent> {
  final EventRepository _repository;

  EventListBloc({required EventRepository repository})
      : _repository = repository {
    _init();
  }

  Future<void> _init() async {
    outEvent.listen((event) {
      event.when(toggleFavorite: (event) async {
        await _repository
            .updateEvent(event.copyWith(isFavorite: !event.isFavorite));
      });
    });

    listen(_repository.getEventsStream(), (events) {
      inState.add(EventListBlocState(eventList: events));
    });

    await _repository.updateRemoteEvents(forceUpdate: true); //todo remove it
  }
}
