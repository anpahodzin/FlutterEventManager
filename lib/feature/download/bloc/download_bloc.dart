import 'package:flutter_event_manager/core/bloc/bloc_base.dart';
import 'package:flutter_event_manager/feature/download/bloc/download_bloc_event.dart';
import 'package:flutter_event_manager/feature/download/bloc/download_bloc_state.dart';
import 'package:flutter_event_manager/feature/event_list/domain/event_repository.dart';

class DownloadBloc
    extends BlocBase<DownloadBlocState, void, DownloadBlocEvent> {
  final EventRepository _repository;

  DownloadBloc({required EventRepository repository})
      : _repository = repository {
    _init();
  }

  Future<void> _init() async {
    outEvent.listen((event) {
      event.when(onDownload: () async {
        inState.add(const DownloadBlocState(isLoading: true));
        await _repository.addRemoteEvents();
        inState.add(const DownloadBlocState(isLoading: false));
      });
    });

    inState.add(const DownloadBlocState(isLoading: false));
  }
}
