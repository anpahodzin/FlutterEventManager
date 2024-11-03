import 'package:flutter_event_manager/feature/event_list/bloc/event_list_bloc.dart';
import 'package:flutter_event_manager/feature/event_list/data/event_data_repository.dart';
import 'package:flutter_event_manager/feature/event_list/data/remote/event_api.dart';
import 'package:flutter_event_manager/feature/event_list/data/remote/fake_event_api.dart';
import 'package:flutter_event_manager/feature/event_list/domain/event_repository.dart';
import 'package:get_it/get_it.dart';

class EventListModule {
  static Future<void> initModule() async {
    var getIt = GetIt.instance;

    // Api
    getIt.registerLazySingleton<EventApi>(() => FakeEventApi());
    // Repository
    getIt.registerLazySingleton<EventRepository>(
      () => EventDataRepository(
        remote: getIt<EventApi>(),
      ),
    );
    // Bloc
    getIt.registerFactory<EventListBloc>(
      () => EventListBloc(
        repository: getIt<EventRepository>(),
      ),
    );
  }
}
