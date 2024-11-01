import 'package:flutter_event_manager/feature/event/data/cache/event_cache.dart';
import 'package:flutter_event_manager/feature/event/data/remote/event_api.dart';
import 'package:flutter_event_manager/feature/event/domain/event_repository.dart';
import 'package:flutter_event_manager/feature/event/domain/model/event.dart';

class EventDataRepository extends EventRepository {
  final EventApi _remote;
  final EventCache _cache;

  const EventDataRepository({
    required EventApi remote,
    required EventCache cache,
  })  : _remote = remote,
        _cache = cache;

  @override
  Future<List<Event>> getRemoteEvents() async {

    final cache = _cache[null];
    if (cache != null) {
      return cache;
    } else {
      final events = await _remote.getRemoteEvents();
      _cache[null] = events;
      return events;
    }
  }
}
