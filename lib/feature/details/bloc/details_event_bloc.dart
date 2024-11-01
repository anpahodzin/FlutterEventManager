import 'package:flutter_event_manager/core/bloc/bloc_base.dart';
import 'package:flutter_event_manager/feature/event_list/domain/event_repository.dart';
import 'package:flutter_event_manager/feature/event_list/domain/model/event.dart';

import 'details_event_bloc_event.dart';
import 'details_event_bloc_state.dart';

class DetailsEventBloc
    extends BlocBase<DetailsEventBlocState, Never, DetailsEventBlocEvent> {
  final Event? _initialEvent;
  final EventRepository _repository;

  DetailsEventBloc({required EventRepository repository, required Event? initialEvent})
      : _repository = repository,
        _initialEvent = initialEvent {
    _init();
  }

  Future<void> _init() async {
    inState.add(DetailsEventBlocState(event: _initialEvent, isNewEvent: false));
  }
}
