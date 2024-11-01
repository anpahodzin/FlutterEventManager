import 'package:flutter/material.dart';
import 'package:flutter_event_manager/core/bloc/bloc_provider.dart';
import 'package:flutter_event_manager/feature/event/list/bloc/event_list_bloc.dart';
import 'package:flutter_event_manager/widget/event_card_widget.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class EventListPage extends StatelessWidget {
  const EventListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: () => GetIt.instance.get<EventListBloc>(),
      child: const _EventListPage(),
    );
  }
}

class _EventListPage extends StatelessWidget {
  const _EventListPage({super.key});

  @override
  Widget build(BuildContext context) {
    var bloc = context.read<EventListBloc>();

    return StreamBuilder(
      stream: bloc.outState,
      builder: (context, snapshot) {
        var state = snapshot.data;
        debugPrint("stream ${snapshot.data}");

        if (state != null && state.eventList.isNotEmpty) {
          return ListView.builder(
            itemCount: state.eventList.length,
            itemBuilder: (context, index) {
              return EventCardWidget(event: state.eventList[index]);
            },
          );
        } else {
          return const Center(child: Text('Empty list')); // todo
        }
      },
    );
  }
}
