import 'package:flutter/material.dart';
import 'package:flutter_event_manager/core/bloc/bloc_listener.dart';

import '../bloc/download_bloc.dart';
import '../bloc/download_bloc_single_state.dart';

class DownloadSingleState
    extends SingleStreamBuilderBase<DownloadBlocSingleState?> {
  final DownloadBloc bloc;

  DownloadSingleState({
    super.key,
    required this.bloc,
  }) : super(stream: bloc.outSingleState);

  @override
  DownloadBlocSingleState? initial() => null;

  @override
  void build(BuildContext context, DownloadBlocSingleState? state) {
    if (state != null) {
      switch (state) {
        case SuccessDownloadEventsSingleState():
          _successDownloadEventsSnackBar(context: context);
      }
    }
  }
}

void _successDownloadEventsSnackBar({
  required BuildContext context,
}) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    final messenger = ScaffoldMessenger.of(context);
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(
          content: Text('Events downloaded successfully'),
        ),
      );
  });
}
