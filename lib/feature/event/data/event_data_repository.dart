import 'package:flutter_event_manager/feature/event/data/remote/event_api.dart';
import 'package:flutter_event_manager/feature/event/domain/event_repository.dart';
import 'package:flutter_event_manager/feature/event/domain/model/event.dart';
import 'package:rxdart/rxdart.dart';

class EventDataRepository extends EventRepository {
  final EventApi _remote;
  final _eventsSubject = BehaviorSubject<List<Event>>();

  EventDataRepository({
    required EventApi remote,
  }) : _remote = remote {
    _eventsSubject.value = [];
  }

  @override
  Future<void> updateRemoteEvents() async {
    final events = await _remote.getRemoteEvents();
    final cachedEvents = _eventsSubject.value.toList();

    for (var remoteEvent in events) {
      final index = cachedEvents.indexWhere((it) => it.id == remoteEvent.id);
      if (index != -1) {
        cachedEvents[index] = remoteEvent;
      } else {
        cachedEvents.add(remoteEvent);
      }
    }

    _eventsSubject.value = cachedEvents;
  }

  @override
  Future<void> addRemoteEvents() async {
    final events = await _remote.getRemoteEvents();
    _eventsSubject.value = _eventsSubject.value.toList()..addAll(events);
  }

  @override
  Stream<List<Event>> getEventsStream() {
    return _eventsSubject.stream;
  }

  @override
  Stream<List<Event>> getFavoritesEventsStream() {
    return _eventsSubject.stream
        .map((events) => events.where((it) => it.isFavorite).toList());
  }

  @override
  Future<void> updateEvent(Event event) async {
    final events = _eventsSubject.value.toList();
    final index = events.indexWhere((it) => it.id == event.id);
    if (index != -1) {
      events[index] = event;
    } else {
      events.add(event);
    }
    _eventsSubject.value = events;
  }

  @override
  Future<void> deleteEvent(Event event) async {
    final events = _eventsSubject.value.toList();
    events.removeWhere((it) => it.id == event.id);
    _eventsSubject.value = events;
  }
}
