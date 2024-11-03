import 'package:flutter_event_manager/feature/event_list/domain/model/event.dart';

abstract class EventListBlocEvent {
  EventListBlocEvent._();

  factory EventListBlocEvent.toggleFavorite({
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

class _ToggleFavorite extends EventListBlocEvent {
  _ToggleFavorite({required this.event}) : super._();
  final Event event;
}
