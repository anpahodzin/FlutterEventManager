import 'package:equatable/equatable.dart';
import 'package:flutter_event_manager/feature/event/domain/model/event.dart';

class DetailsEventBlocState extends Equatable {
  final Event? event;
  final bool isNewEvent;

  const DetailsEventBlocState({
    required this.event,
    required this.isNewEvent,
  });

  @override
  List<Object?> get props => [event, isNewEvent];
}
