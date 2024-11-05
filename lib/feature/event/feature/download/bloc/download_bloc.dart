import 'package:flutter_event_manager/core/bloc/bloc_base.dart';
import 'package:flutter_event_manager/feature/event/domain/event_repository.dart';
import 'package:flutter_event_manager/feature/event/feature/download/bloc/download_bloc_event.dart';
import 'package:flutter_event_manager/feature/event/feature/download/bloc/download_bloc_single_state.dart';
import 'package:flutter_event_manager/feature/event/feature/download/bloc/download_bloc_state.dart';

class DownloadBloc extends BlocBase<DownloadBlocState, DownloadBlocSingleState,
    DownloadBlocEvent> {
  final EventRepository _repository;

  DownloadBloc({required EventRepository repository})
      : _repository = repository {
    _init();
  }

  Future<void> _init() async {
    outEvent.listen((event) {
      event.when(onDownload: () async {
        inState.add(const DownloadBlocState(isLoading: true));
        await _repository.updateRemoteEvents();
        inState.add(const DownloadBlocState(isLoading: false));
        inSingleState.add(SuccessDownloadEventsSingleState());
      });
    });

    inState.add(const DownloadBlocState(isLoading: false));
  }
}
