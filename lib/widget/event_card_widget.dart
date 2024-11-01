import 'package:flutter/material.dart';
import 'package:flutter_event_manager/feature/event/domain/model/event.dart';

class EventCardWidget extends StatelessWidget {
  final Event _event;
  final Function(Event) _onItemTapped;

  const EventCardWidget({
    super.key,
    required Event event,
    required Function(Event) onItemTapped,
  })  : _event = event,
        _onItemTapped = onItemTapped;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      //todo
      clipBehavior: Clip.hardEdge,
      color: Colors.white,
      child: _eventItem(
        event: _event,
        // onTaskComplete: _onTaskComplete,
        // onTap: _onEditTask,
      ),
    );
  }

  Widget _eventItem({
    required Event event,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.only(right: 8, top: 4, bottom: 4), //todo
      title: Text(
        event.title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        event.description,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      onTap: () => _onItemTapped(_event),
    );
  }
}
