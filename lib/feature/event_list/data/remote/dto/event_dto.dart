import 'package:flutter_event_manager/feature/event_list/domain/model/event.dart';

class EventDto {
  final String id;
  final String title;
  final String location;
  final String date;
  final String description;
  final bool isFavorite;

  EventDto({
    required this.id,
    required this.title,
    required this.location,
    required this.date,
    required this.description,
    required this.isFavorite,
  });

  factory EventDto.fromJson(Map<String, dynamic> json) {
    return EventDto(
      id: json['id'],
      title: json['title'],
      location: json['location'],
      date: json['date'],
      description: json['description'],
      isFavorite: json['isFavorite'],
    );
  }

  Event toDomain() => Event(
        id: id,
        title: title,
        location: location,
        date: DateTime.parse(date),
        description: description,
        isFavorite: isFavorite,
      );
}