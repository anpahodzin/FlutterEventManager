/*
"id": "1",
"title": "Flutter Workshop",
"location": "New York City",
"date": "2024-11-10T14:00:00Z",
"description": "A comprehensive workshop on building Flutter apps.",
"isFavorite": false
*/

import 'package:equatable/equatable.dart';
import 'package:uuid/v1.dart';

class Event extends Equatable {
  final String id;
  final String title;
  final String location;
  final DateTime date;
  final String description;
  final bool isFavorite;

  const Event({
    required this.id,
    required this.title,
    required this.location,
    required this.date,
    required this.description,
    required this.isFavorite,
  });

  Event.initial()
      : id = const UuidV1().generate(),
        title = "",
        location = "",
        date = DateTime.now(),
        description = "",
        isFavorite = false;

  @override
  List<Object?> get props =>
      [id, title, location, date, description, isFavorite];

  Event copyWith({
    String? id,
    String? title,
    String? location,
    DateTime? date,
    String? description,
    bool? isFavorite,
  }) {
    return Event(
        id: id ?? this.id,
        title: title ?? this.title,
        location: location ?? this.location,
        date: date ?? this.date,
        description: description ?? this.description,
        isFavorite: isFavorite ?? this.isFavorite);
  }
}
