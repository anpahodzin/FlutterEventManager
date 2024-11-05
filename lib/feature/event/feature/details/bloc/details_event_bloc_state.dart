import 'package:equatable/equatable.dart';
import 'package:flutter_event_manager/feature/event/domain/model/event.dart';

class DetailsEventBlocState extends Equatable {
  final Event event;
  final bool isEditing;
  final bool isNewEvent;

  const DetailsEventBlocState({
    required this.event,
    required this.isEditing,
    required this.isNewEvent,
  });

  @override
  List<Object?> get props => [event, isEditing, isNewEvent];

  DetailsEventBlocState copyWith({
    Event? event,
    bool? isEditing,
    bool? isNewEvent,
  }) {
    return DetailsEventBlocState(
      event: event ?? this.event,
      isEditing: isEditing ?? this.isEditing,
      isNewEvent: isNewEvent ?? this.isNewEvent,
    );
  }
}
