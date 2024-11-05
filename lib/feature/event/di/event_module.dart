import 'package:flutter_event_manager/feature/event/data/event_data_repository.dart';
import 'package:flutter_event_manager/feature/event/data/remote/event_api.dart';
import 'package:flutter_event_manager/feature/event/data/remote/fake_event_api.dart';
import 'package:flutter_event_manager/feature/event/domain/event_repository.dart';
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
  }
}
