import 'model/event.dart';

abstract class EventRepository {

  Future<void> updateRemoteEvents({bool forceUpdate = false});

  Stream<List<Event>> getEventsStream();

  Stream<List<Event>> getFavoritesEventsStream();

  Future<void> updateEvent(Event event);
}