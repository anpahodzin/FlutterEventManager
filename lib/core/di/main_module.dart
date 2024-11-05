import 'package:flutter_event_manager/feature/event/di/event_module.dart';
import 'package:flutter_event_manager/feature/event/feature/details/di/details_event_module.dart';
import 'package:flutter_event_manager/feature/event/feature/download/di/download_module.dart';
import 'package:flutter_event_manager/feature/event/feature/event_list/di/event_list_module.dart';
import 'package:flutter_event_manager/feature/event/feature/favorite/di/favorite_module.dart';

class MainModule {
  static Future<void> initModule() async {
    //Core

    //Future
    EventModule.initModule();
    EventListModule.initModule();
    DetailsEventModule.initModule();
    FavoriteModule.initModule();
    DownloadModule.initModule();
  }
}
