import 'dart:async';

import 'package:flutter_event_manager/feature/event_list/domain/model/event.dart';

abstract class EventApi {
  FutureOr<List<Event>> getRemoteEvents();
}