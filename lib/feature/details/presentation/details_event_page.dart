import 'package:flutter/material.dart';
import 'package:flutter_event_manager/core/bloc/bloc_provider.dart';
import 'package:flutter_event_manager/feature/details/bloc/details_event_bloc.dart';
import 'package:flutter_event_manager/feature/details/bloc/details_event_bloc_event.dart';
import 'package:flutter_event_manager/feature/details/bloc/details_event_bloc_state.dart';
import 'package:flutter_event_manager/feature/event_list/domain/model/event.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DetailsEventPage extends StatelessWidget {
  final Event? _event;

  const DetailsEventPage({super.key, required Event? event}) : _event = event;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: () => GetIt.instance.get<DetailsEventBloc>(param1: _event),
      child: const DetailEventContent(),
    );
  }
}

class DetailEventContent extends StatefulWidget {
  const DetailEventContent({super.key});

  @override
  State createState() => _DetailEventContentState();
}

class _DetailEventContentState extends State<DetailEventContent> {
  @override
  Widget build(BuildContext context) {
    var bloc = context.read<DetailsEventBloc>();

    return StreamBuilder(
      stream: bloc.outState,
      builder: (context, snapshot) {
        final state = snapshot.data;
        debugPrint("stream ${snapshot.data}");
        if (state != null) {
          return Scaffold(
            appBar: _toolbar(
              context: context,
              isEditing: state.isEditing,
              isFavorite: state.event.isFavorite,
              onSaveTap: () {
                bloc.inEvent.add(DetailsEventBlocEvent.toggleEditMode());
              },
              toggleEditMode: () {
                bloc.inEvent.add(DetailsEventBlocEvent.toggleEditMode());
              },
              onFavoriteTap: () {
                bloc.inEvent.add(DetailsEventBlocEvent.toggleFavorite());
              },
            ),
            body: _content(state: state),
          );
        } else {
          return const Center(child: Text(""));
        }
      },
    );
  }

  AppBar _toolbar({
    required BuildContext context,
    required bool isEditing,
    required bool isFavorite,
    required Function() onSaveTap,
    required Function() toggleEditMode,
    required Function() onFavoriteTap,
  }) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      title: Text(isEditing ? "Edit Item" : "Details Screen"), //todo
      leading: IconButton(
        onPressed: () {
          context.pop();
        },
        icon: const Icon(Icons.arrow_back),
      ),
      actions: [
        if (isEditing)
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: onSaveTap,
          )
        else
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: toggleEditMode,
          ),
        IconButton(
          onPressed: onFavoriteTap,
          icon: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border,
            color: isFavorite ? Colors.red : Colors.grey,
          ),
        ),
        const SizedBox(width: 16)
      ],
    );
  }

  Widget _content({required DetailsEventBlocState state}) {
    final event = state.event;
    final isEditing = state.isEditing;

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 800),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _editText(
                isEditing: isEditing,
                labelText: "Title", //todo
                initialValue: event.title,
                onTextChanged: (text) {},
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              _editText(
                isEditing: isEditing,
                labelText: "Description", //todo
                initialValue: event.description,
                onTextChanged: (text) {},
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 8),
              _editText(
                isEditing: isEditing,
                labelText: "Location", //todo
                initialValue: event.location,
                onTextChanged: (text) {},
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
              const SizedBox(height: 8),
              Text(
                "Date: ${DateFormat('d MMM y').format(event.date)}", //todo
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
              // const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _editText({
    required bool isEditing,
    String? labelText,
    String? initialValue,
    Function(String text)? onTextChanged,
    String? errorText,
    TextStyle? style,
  }) {
    return TextFormField(
      initialValue: initialValue,
      onChanged: onTextChanged,
      maxLines: null,
      style: style,
      decoration: InputDecoration(
        labelText: labelText,
        errorText: errorText,
      ),
      readOnly: !isEditing,
      autofocus: isEditing,
      canRequestFocus: isEditing,
    );
  }
}
