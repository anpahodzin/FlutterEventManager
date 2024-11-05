import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_event_manager/feature/event/feature/download/bloc/download_bloc.dart';
import 'package:flutter_event_manager/feature/event/feature/download/bloc/download_bloc_event.dart';
import 'package:get_it/get_it.dart';
import 'package:side_effect_bloc/side_effect_bloc.dart';

import '../bloc/download_bloc_state.dart';

class DownloadPage extends StatelessWidget {
  const DownloadPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return GetIt.instance<DownloadBloc>();
      },
      child: const _DownloadPageContent(),
    );
  }
}

class _DownloadPageContent extends StatelessWidget {
  const _DownloadPageContent();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<DownloadBloc>();

    return BlocSideEffectListener(
      bloc: bloc,
      listener: (context, sideEffect) {
        _successDownloadEventsSnackBar(context: context);
      },
      child: BlocBuilder(
        bloc: bloc,
        builder: (context, DownloadBlocState state) {
          if (!state.isLoading) {
            return Center(
              child: ElevatedButton(
                onPressed: () {
                  bloc.add(DownloadEventsFromFile());
                },
                child: const Text('Update events from file'),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
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
}
