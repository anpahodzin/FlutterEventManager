import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_event_manager/feature/event/domain/event_repository.dart';
import 'package:flutter_event_manager/feature/event/domain/model/event.dart';

import 'details_event_bloc_event.dart';
import 'details_event_bloc_state.dart';

class DetailsEventBloc
    extends Bloc<DetailsEventBlocEvent, DetailsEventBlocState> {
  final EventRepository _repository;

  DetailsEventBloc(
      {required EventRepository repository, required Event? initialEvent})
      : _repository = repository,
        super(DetailsEventBlocState(
          event: initialEvent ?? Event.initial(),
          isEditing: initialEvent == null ? true : false,
          isNewEvent: initialEvent == null,
        )) {
    on<DetailsEventToggleEditMode>((event, emit) {
      emit.call(state.copyWith(isEditing: true));
    });
    on<DetailsEventSaveEvent>((event, emit) async {
      await _repository.updateEvent(state.event);
      emit.call(state.copyWith(isEditing: true));
    });
    on<DetailsEventToggleFavorite>((event, emit) async {
      final event = state.event;
      final newEvent = event.copyWith(isFavorite: !event.isFavorite);
      await _repository.updateEvent(newEvent);
      emit.call(state.copyWith(event: newEvent));
    });
    on<DetailsEventUpdateText>((event, emit) async {
      emit.call(state.copyWith(
          event: state.event.copyWith(
        title: event.title,
        description: event.description,
        location: event.location,
      )));
    });
  }
}
