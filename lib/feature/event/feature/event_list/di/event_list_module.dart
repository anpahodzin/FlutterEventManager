import 'package:flutter_event_manager/feature/event/domain/event_repository.dart';
import 'package:flutter_event_manager/feature/event/feature/event_list/bloc/event_list_bloc.dart';
import 'package:get_it/get_it.dart';

class EventListModule {
  static Future<void> initModule() async {
    final getIt = GetIt.instance;

    // Bloc
    getIt.registerFactory<EventListBloc>(
      () => EventListBloc(
        repository: getIt<EventRepository>(),
      ),
    );
  }
}
