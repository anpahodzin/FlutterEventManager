import 'package:flutter_event_manager/feature/event/domain/model/event.dart';

sealed class EventListBlocEvent {}

class EventListGetAllEvents extends EventListBlocEvent {
  EventListGetAllEvents({required this.events});

  final List<Event> events;
}

class EventListToggleFavorite extends EventListBlocEvent {
  EventListToggleFavorite({required this.event});

  final Event event;
}
