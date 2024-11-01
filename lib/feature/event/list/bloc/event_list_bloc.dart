import 'package:flutter_event_manager/core/bloc/bloc_base.dart';

import 'event_list_bloc_event.dart';
import 'event_list_bloc_state.dart';

class EventListBloc
    extends BlocBase<EventListBlocState, Never, EventListBlocEvent> {
  EventListBloc() {
    _init();
  }

  Future<void> _init() async {
    inState.add(const EventListBlocState(eventList: []));
  }
}
