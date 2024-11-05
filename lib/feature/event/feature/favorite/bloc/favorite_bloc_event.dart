import 'package:flutter_event_manager/feature/event/domain/model/event.dart';

abstract class FavoriteBlocEvent {}

class FavoriteGetAllEvents extends FavoriteBlocEvent {
  FavoriteGetAllEvents({required this.events});

  final List<Event> events;
}

class FavoriteToggleFavorite extends FavoriteBlocEvent {
  FavoriteToggleFavorite({required this.event});

  final Event event;
}
