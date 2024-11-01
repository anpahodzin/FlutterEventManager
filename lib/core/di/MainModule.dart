import 'package:flutter_event_manager/feature/event/di/event_list_module.dart';
import 'package:get_it/get_it.dart';

class MainModule {
  static Future<void> initModule() async {
    var getIt = GetIt.instance;
    //Core

    //Future
    EventListModule.initModule();
  }
}
