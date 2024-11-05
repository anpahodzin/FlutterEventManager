import 'package:flutter_event_manager/core/bloc/bloc_base.dart';
import 'package:flutter_event_manager/feature/event/domain/event_repository.dart';

import 'favorite_bloc_event.dart';
import 'favorite_bloc_state.dart';

class FavoriteBloc
    extends BlocBase<FavoriteBlocState, void, FavoriteBlocEvent> {
  final EventRepository _repository;

  FavoriteBloc({required EventRepository repository})
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

    listen(_repository.getFavoritesEventsStream(), (favorites) {
      inState.add(FavoriteBlocState(favorites: favorites));
    });
  }
}
