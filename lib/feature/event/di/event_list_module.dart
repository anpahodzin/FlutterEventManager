import 'package:flutter_event_manager/feature/event/list/bloc/event_list_bloc.dart';
import 'package:get_it/get_it.dart';

class EventListModule {
  static Future<void> initModule() async {
    var getIt = GetIt.instance;

    // Bloc
    getIt.registerFactory<EventListBloc>(() => EventListBloc());
  }
}
