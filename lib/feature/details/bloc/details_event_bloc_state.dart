import 'package:equatable/equatable.dart';
import 'package:flutter_event_manager/feature/event_list/domain/model/event.dart';

class DetailsEventBlocState extends Equatable {
  final Event event;
  final bool isEditing;

  const DetailsEventBlocState({
    required this.event,
    required this.isEditing,
  });

  @override
  List<Object?> get props => [event, isEditing];

  DetailsEventBlocState copyWith({
    Event? event,
    bool? isEditing,
  }) {
    return DetailsEventBlocState(
      event: event ?? this.event,
      isEditing: isEditing ?? this.isEditing,
    );
  }
}
