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
    inState.add(const EventListBlocState(eventList: []));

    final events = await _repository.getRemoteEvents();

    inState.add(EventListBlocState(eventList: events));
  }
}
