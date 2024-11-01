/*
"id": "1",
"title": "Flutter Workshop",
"location": "New York City",
"date": "2024-11-10T14:00:00Z",
"description": "A comprehensive workshop on building Flutter apps.",
"isFavorite": false
*/

class Event {
  final String id;
  final String title;
  final String location;
  final DateTime date;
  final String description;
  final bool isFavorite;

  Event({
    required this.id,
    required this.title,
    required this.location,
    required this.date,
    required this.description,
    required this.isFavorite,
  });

  @override
  String toString() {
    return "{id:$id, title:$title, location:$location, date:$date, description:$description, isFavorite:$isFavorite}";
  }
}
