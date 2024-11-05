import 'package:flutter_event_manager/feature/event/data/event_data_repository.dart';
import 'package:flutter_event_manager/feature/event/data/remote/event_api.dart';
import 'package:flutter_event_manager/feature/event/data/remote/fake_event_api.dart';
import 'package:flutter_event_manager/feature/event/domain/event_repository.dart';
import 'package:flutter_event_manager/feature/event/feature/details/di/details_event_module.dart';
import 'package:flutter_event_manager/feature/event/feature/download/di/download_module.dart';
import 'package:flutter_event_manager/feature/event/feature/event_list/di/event_list_module.dart';
import 'package:flutter_event_manager/feature/event/feature/favorite/di/favorite_module.dart';
import 'package:get_it/get_it.dart';

class EventModule {
  static Future<void> initModule() async {
    final getIt = GetIt.instance;

    // Api
    getIt.registerLazySingleton<EventApi>(() => FakeEventApi());
    // Repository
    getIt.registerLazySingleton<EventRepository>(
      () => EventDataRepository(
        remote: getIt<EventApi>(),
      ),
    );
    // Feature
    EventListModule.initModule();
    DetailsEventModule.initModule();
    FavoriteModule.initModule();
    DownloadModule.initModule();
  }
}
