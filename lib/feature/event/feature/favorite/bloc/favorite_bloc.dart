import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_event_manager/feature/event/domain/event_repository.dart';
import 'package:rxdart/rxdart.dart';

import 'favorite_bloc_event.dart';
import 'favorite_bloc_state.dart';

class FavoriteBloc extends Bloc<FavoriteBlocEvent, FavoriteBlocState> {
  final EventRepository _repository;
  final _compositeSubscription = CompositeSubscription();

  FavoriteBloc({required EventRepository repository})
      : _repository = repository,
        super(const FavoriteBlocState(favorites: [])) {
    on<FavoriteGetAllEvents>((event, emit) async {
      emit(state.copyWith(favorites: event.events));
    });
    on<FavoriteToggleFavorite>((blocEvent, emit) async {
      final event = blocEvent.event;
      await _repository
          .updateEvent(event.copyWith(isFavorite: !event.isFavorite));
    });
    _init();
  }

  Future<void> _init() async {
    _compositeSubscription
        .add(_repository.getFavoritesEventsStream().listen((events) {
      add(FavoriteGetAllEvents(events: events));
    }));
  }

  @override
  Future<void> close() {
    _compositeSubscription.cancel();
    return super.close();
  }
}
