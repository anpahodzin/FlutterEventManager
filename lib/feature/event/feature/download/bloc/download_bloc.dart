import 'package:flutter_event_manager/feature/event/domain/event_repository.dart';
import 'package:flutter_event_manager/feature/event/feature/download/bloc/download_bloc_event.dart';
import 'package:flutter_event_manager/feature/event/feature/download/bloc/download_bloc_side_effect.dart';
import 'package:flutter_event_manager/feature/event/feature/download/bloc/download_bloc_state.dart';
import 'package:side_effect_bloc/side_effect_bloc.dart';

class DownloadBloc extends SideEffectBloc<DownloadBlocEvent, DownloadBlocState,
    DownloadBlocSideEffect> {
  final EventRepository _repository;

  DownloadBloc({required EventRepository repository})
      : _repository = repository,
        super(const DownloadBlocState(isLoading: false)) {
    on<DownloadEventsFromFile>((event, emit) async {
      emit.call(state.copyWith(isLoading: true));
      await _repository.updateRemoteEvents();
      emit.call(state.copyWith(isLoading: false));
      produceSideEffect(SuccessDownloadEventsSideEffect());
    });
  }
}
