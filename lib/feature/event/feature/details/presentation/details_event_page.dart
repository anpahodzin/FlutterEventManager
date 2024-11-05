import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_event_manager/feature/event/domain/model/event.dart';
import 'package:flutter_event_manager/feature/event/feature/details/bloc/details_event_bloc.dart';
import 'package:flutter_event_manager/feature/event/feature/details/bloc/details_event_bloc_event.dart';
import 'package:flutter_event_manager/feature/event/feature/details/bloc/details_event_bloc_state.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class DetailsEventPage extends StatelessWidget {
  final Event? _event;

  const DetailsEventPage({super.key, required Event? event}) : _event = event;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return GetIt.instance<DetailsEventBloc>(param1: _event);
      },
      child: const _DetailEventContent(),
    );
  }
}

class _DetailEventContent extends StatelessWidget {
  const _DetailEventContent();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<DetailsEventBloc>();

    return BlocBuilder(
      bloc: bloc,
      builder: (context, DetailsEventBlocState state) {
        return Scaffold(
          appBar: _toolbar(
            context: context,
            isEditing: state.isEditing,
            isFavorite: state.event.isFavorite,
            isNewEvent: state.isNewEvent,
            onSaveTap: () {
              bloc.add(DetailsEventSaveEvent());
            },
            toggleEditMode: () {
              bloc.add(DetailsEventToggleEditMode());
            },
            onFavoriteTap: () {
              bloc.add(DetailsEventToggleFavorite());
            },
          ),
          body: _content(
            state: state,
            onTitleChange: (text) {
              bloc.add(DetailsEventUpdateText(title: text));
            },
            onDescriptionChange: (text) {
              bloc.add(DetailsEventUpdateText(description: text));
            },
            onLocationChange: (text) {
              bloc.add(DetailsEventUpdateText(location: text));
            },
          ),
        );
      },
    );
  }
}

AppBar _toolbar({
  required BuildContext context,
  required bool isEditing,
  required bool isFavorite,
  required bool isNewEvent,
  required Function() onSaveTap,
  required Function() toggleEditMode,
  required Function() onFavoriteTap,
}) {
  final title = isNewEvent
      ? "Create Event"
      : (isEditing ? "Edit Event" : "Event Details");
  return AppBar(
    backgroundColor: Theme.of(context).colorScheme.inversePrimary,
    title: Text(title),
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

Widget _content({
  required DetailsEventBlocState state,
  required Function(String) onTitleChange,
  required Function(String) onDescriptionChange,
  required Function(String) onLocationChange,
}) {
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
              labelText: "Title",
              initialValue: event.title,
              onTextChanged: onTitleChange,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            _editText(
              isEditing: isEditing,
              labelText: "Description",
              initialValue: event.description,
              onTextChanged: onDescriptionChange,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            _editText(
              isEditing: isEditing,
              labelText: "Location",
              initialValue: event.location,
              onTextChanged: onLocationChange,
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            const SizedBox(height: 8),
            Text(
              "Date: ${DateFormat('d MMM y').format(event.date)}",
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
