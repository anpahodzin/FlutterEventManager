import 'dart:async';

import 'package:flutter_event_manager/feature/event/domain/model/event.dart';

abstract class EventApi {
  FutureOr<List<Event>> getRemoteEvents();
}