import 'package:flutter_event_manager/feature/event_list/data/remote/event_api.dart';
import 'package:flutter_event_manager/feature/event_list/domain/event_repository.dart';
import 'package:flutter_event_manager/feature/event_list/domain/model/event.dart';
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
  Future<void> updateRemoteEvents({bool forceUpdate = true}) async {
    final cache = _eventsSubject.valueOrNull;
    if (cache == null || forceUpdate) {
      final events = await _remote.getRemoteEvents();
      _eventsSubject.value = events;
    }
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
    _eventsSubject.value = List.from(events);
  }
}
