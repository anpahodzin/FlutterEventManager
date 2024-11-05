import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_event_manager/feature/event/domain/event_repository.dart';
import 'package:rxdart/rxdart.dart';

import 'event_list_bloc_event.dart';
import 'event_list_bloc_state.dart';

class EventListBloc extends Bloc<EventListBlocEvent, EventListBlocState> {
  final EventRepository _repository;
  final _compositeSubscription = CompositeSubscription();

  EventListBloc({required EventRepository repository})
      : _repository = repository,
        super(const EventListBlocState(eventList: [])) {
    on<EventListGetAllEvents>((event, emit) async {
      emit(state.copyWith(eventList: event.events));
    });
    on<EventListToggleFavorite>((blocEvent, emit) async {
      final event = blocEvent.event;
      await _repository
          .updateEvent(event.copyWith(isFavorite: !event.isFavorite));
    });
    _init();
  }

  Future<void> _init() async {
    _compositeSubscription.add(_repository.getEventsStream().listen((events) {
      add(EventListGetAllEvents(events: events));
    }));
  }

  @override
  Future<void> close() {
    _compositeSubscription.cancel();
    return super.close();
  }
}
