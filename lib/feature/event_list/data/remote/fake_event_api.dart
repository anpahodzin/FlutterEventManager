import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_event_manager/feature/event_list/data/remote/event_api.dart';
import 'package:flutter_event_manager/feature/event_list/domain/model/event.dart';

import 'dto/event_dto.dart';

class FakeEventApi extends EventApi {
  @override
  FutureOr<List<Event>> getRemoteEvents() async {
    await Future.delayed(const Duration(seconds: 2));

    String jsonString = await rootBundle.loadString('assets/events.json');

    List<dynamic> jsonList = json.decode(jsonString);

    debugPrint(jsonList.toString());

    return jsonList.map((json) => EventDto.fromJson(json).toDomain()).toList();
  }
}
