import 'package:flutter/material.dart';
import 'package:flutter_event_manager/core/bloc/bloc_multi_provider.dart';
import 'package:flutter_event_manager/feature/download/bloc/download_bloc.dart';
import 'package:flutter_event_manager/feature/download/bloc/download_bloc_event.dart';
import 'package:flutter_event_manager/feature/download/presentation/download_single_state.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class DownloadPage extends StatelessWidget {
  const DownloadPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocMultiProvider<DownloadBloc>(
      bloc: () => GetIt.instance.get<DownloadBloc>(),
      providerFactories: [(context, bloc) => DownloadSingleState(bloc: bloc)],
      child: const _DownloadPage(),
    );
  }
}

class _DownloadPage extends StatelessWidget {
  const _DownloadPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<DownloadBloc>();

    return StreamBuilder(
      stream: bloc.outState,
      builder: (context, snapshot) {
        final state = snapshot.data;
        debugPrint("stream ${snapshot.data}");
        if (state != null && !state.isLoading) {
          return Center(
            child: ElevatedButton(
              onPressed: () {
                bloc.inEvent.add(DownloadBlocEvent.download());
              },
              child: const Text('Update events from file'), // todo
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
