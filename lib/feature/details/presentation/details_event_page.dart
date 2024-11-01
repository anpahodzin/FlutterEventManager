import 'package:flutter/material.dart';
import 'package:flutter_event_manager/core/bloc/bloc_provider.dart';
import 'package:flutter_event_manager/feature/details/bloc/details_event_bloc.dart';
import 'package:flutter_event_manager/feature/event_list/domain/model/event.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class DetailsEventPage extends StatelessWidget {
  final Event? _event;

  const DetailsEventPage({super.key, required Event? event}) : _event = event;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: () => GetIt.instance.get<DetailsEventBloc>(param1: _event),
      child: const _DetailsEventPage(),
    );
  }
}

class _DetailsEventPage extends StatelessWidget {
  const _DetailsEventPage({super.key});

  @override
  Widget build(BuildContext context) {
    var bloc = context.read<DetailsEventBloc>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Details"),//todo
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: StreamBuilder(
          stream: bloc.outState,
          builder: (context, snapshot) {
            var state = snapshot.data;
            debugPrint("stream ${snapshot.data}");
            // if(sta)
            return ListView(
              children: [],
            );
          }),
    );
  }

  Widget _body(Event event) {
    return ListView(
      children: [Text(event.title)],
    );
  }
}
