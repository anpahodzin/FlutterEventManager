import 'package:flutter_event_manager/core/bloc/bloc_base.dart';
import 'package:flutter_event_manager/feature/event_list/domain/event_repository.dart';
import 'package:flutter_event_manager/feature/event_list/domain/model/event.dart';

import 'details_event_bloc_event.dart';
import 'details_event_bloc_state.dart';

class DetailsEventBloc
    extends BlocBase<DetailsEventBlocState, Never, DetailsEventBlocEvent> {
  final Event _event;
  final EventRepository _repository;

  DetailsEventBloc(
      {required EventRepository repository, required Event? initialEvent})
      : _repository = repository,
        _event = initialEvent ?? Event.initial() {
    _init();
  }

  Future<void> _init() async {
    inState.add(DetailsEventBlocState(event: _event, isEditing: false));

    outEvent.listen((event) {
      event.when(
        toggleEditMode: () async {
          final state = await outState.first;
          inState.add(state.copyWith(isEditing: !state.isEditing));
        },
        saveEvent: () {},
        toggleFavorite: () {
          _updateEventState(
            (event) => event.copyWith(isFavorite: !event.isFavorite),
          );
        },
        updateTitle: (String title) {
          _updateEventState((event) => event.copyWith(title: title));
        },
        updateDescription: (String description) {
          _updateEventState(
              (event) => event.copyWith(description: description));
        },
        updateLocation: (String location) {
          _updateEventState((event) => event.copyWith(location: location));
        },
      );
    });
  }

  void _updateEventState(Event Function(Event) block) async {
    final event = (await outState.first).event;
    inState.add(state.copyWith(event: block(event)));
  }
}
