import 'package:flutter_event_manager/feature/details/di/details_event_module.dart';
import 'package:flutter_event_manager/feature/download/di/download_module.dart';
import 'package:flutter_event_manager/feature/event_list/di/event_list_module.dart';
import 'package:flutter_event_manager/feature/favorite/di/favorite_module.dart';
import 'package:get_it/get_it.dart';

class MainModule {
  static Future<void> initModule() async {
    final getIt = GetIt.instance;
    //Core

    //Future
    EventListModule.initModule();
    DetailsEventModule.initModule();
    FavoriteModule.initModule();
    DownloadModule.initModule();
  }
}
