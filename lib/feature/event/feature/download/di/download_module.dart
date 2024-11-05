import 'package:flutter_event_manager/feature/event/domain/event_repository.dart';
import 'package:flutter_event_manager/feature/event/feature/download/bloc/download_bloc.dart';
import 'package:get_it/get_it.dart';

class DownloadModule {
  static Future<void> initModule() async {
    final getIt = GetIt.instance;

    // Bloc
    getIt.registerFactory<DownloadBloc>(
        () => DownloadBloc(repository: getIt<EventRepository>()));
  }
}
