import 'package:flutter_event_manager/feature/details/bloc/details_event_bloc.dart';
import 'package:flutter_event_manager/feature/event_list/domain/event_repository.dart';
import 'package:flutter_event_manager/feature/event_list/domain/model/event.dart';
import 'package:get_it/get_it.dart';

class DetailsEventModule {
  static Future<void> initModule() async {
    final getIt = GetIt.instance;

    // Bloc
    getIt.registerFactoryParam<DetailsEventBloc, Event?, void>((event, param) {
      return DetailsEventBloc(
          repository: getIt<EventRepository>(), initialEvent: event);
    });
  }
}
