import 'package:flutter_event_manager/feature/event_list/domain/model/event.dart';

abstract class FavoriteBlocEvent {
  FavoriteBlocEvent._();

  factory FavoriteBlocEvent.toggleFavorite({
    required Event event,
  }) = _ToggleFavorite;

  void when({
    required Function(Event) toggleFavorite,
  }) {
    var event = this;
    if (event is _ToggleFavorite) {
      toggleFavorite(event.event);
    }
  }
}

class _ToggleFavorite extends FavoriteBlocEvent {
  _ToggleFavorite({required this.event}) : super._();
  final Event event;
}
