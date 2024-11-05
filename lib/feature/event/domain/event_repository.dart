import 'model/event.dart';

abstract class EventRepository {

  Future<void> updateRemoteEvents();

  Future<void> addRemoteEvents();

  Stream<List<Event>> getEventsStream();

  Stream<List<Event>> getFavoritesEventsStream();

  Future<void> updateEvent(Event event);

  Future<void> deleteEvent(Event event);
}