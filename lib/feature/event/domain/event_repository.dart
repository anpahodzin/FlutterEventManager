import 'model/event.dart';

abstract class EventRepository {
  const EventRepository();

  Future<List<Event>> getRemoteEvents();
}