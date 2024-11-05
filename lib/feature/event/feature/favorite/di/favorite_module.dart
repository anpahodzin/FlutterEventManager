import 'package:flutter_event_manager/feature/event/domain/event_repository.dart';
import 'package:flutter_event_manager/feature/event/feature/favorite/bloc/favorite_bloc.dart';
import 'package:get_it/get_it.dart';

class FavoriteModule {
  static Future<void> initModule() async {
    final getIt = GetIt.instance;

    // Bloc
    getIt.registerFactory<FavoriteBloc>(
        () => FavoriteBloc(repository: getIt<EventRepository>()));
  }
}
