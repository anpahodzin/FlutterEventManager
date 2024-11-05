import 'package:flutter/material.dart';
import 'package:flutter_event_manager/feature/event/domain/model/event.dart';
import 'package:intl/intl.dart';

class EventCard extends StatelessWidget {
  final Event _event;
  final Function(Event) _onItemTap;
  final Function(Event) _onFavoriteTap;

  const EventCard(
      {super.key,
      required Event event,
      required Function(Event) onItemTap,
      required Function(Event) onFavoriteTap})
      : _event = event,
        _onItemTap = onItemTap,
        _onFavoriteTap = onFavoriteTap;

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('d MMM y').format(_event.date);
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      margin: const EdgeInsets.all(8),
      child: InkWell(
        onTap: () => _onItemTap(_event),
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _event.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _event.description,
                      style: const TextStyle(fontSize: 16),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "$formattedDate ${_event.location}",
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () => _onFavoriteTap(_event),
                icon: Icon(
                  _event.isFavorite ? Icons.favorite : Icons.favorite_border,
                  size: 24,
                  color: _event.isFavorite ? Colors.red : Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
