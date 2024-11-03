import 'package:equatable/equatable.dart';
import 'package:flutter_event_manager/feature/event_list/domain/model/event.dart';

class EventListBlocState extends Equatable {
  const EventListBlocState({
    required this.eventList,
  });

  final List<Event> eventList;

  @override
  List<Object?> get props => [eventList];

  EventListBlocState copyWith({List<Event>? eventList}) {
    return EventListBlocState(
      eventList: eventList ?? List.from(this.eventList),
    );
  }
}
