import 'package:flutter_event_manager/feature/event/di/event_module.dart';

class MainModule {
  static Future<void> initModule() async {
    //Core

    //Future
    EventModule.initModule();
  }
}
