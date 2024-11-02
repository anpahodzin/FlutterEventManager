import 'package:flutter_event_manager/core/extension.dart';

abstract class DetailsEventBlocEvent {
  DetailsEventBlocEvent._();

  factory DetailsEventBlocEvent.toggleEditMode() = _ToggleEditMode;

  factory DetailsEventBlocEvent.saveEvent() = _SaveEvent;

  factory DetailsEventBlocEvent.toggleFavorite() = _ToggleFavorite;

  factory DetailsEventBlocEvent.updateText(
      {String? title, String? description, String? location}) = _UpdateText;

  void when({
    required Function() toggleEditMode,
    required Function() saveEvent,
    required Function() toggleFavorite,
    required Function(String title) updateTitle,
    required Function(String description) updateDescription,
    required Function(String location) updateLocation,
  }) {
    var event = this;
    if (event is _ToggleEditMode) {
      toggleEditMode();
    }
    if (event is _SaveEvent) {
      saveEvent();
    }
    if (event is _ToggleFavorite) {
      toggleFavorite();
    }
    if (event is _UpdateText) {
      event.title?.ifNotNull((it) {
        updateTitle(it);
      });
      event.description?.ifNotNull((it) {
        updateDescription(it);
      });
      event.location?.ifNotNull((it) {
        updateLocation(it);
      });
    }
  }
}

class _ToggleEditMode extends DetailsEventBlocEvent {
  _ToggleEditMode() : super._();
}

class _SaveEvent extends DetailsEventBlocEvent {
  _SaveEvent() : super._();
}

class _ToggleFavorite extends DetailsEventBlocEvent {
  _ToggleFavorite() : super._();
}

class _UpdateText extends DetailsEventBlocEvent {
  _UpdateText({this.title, this.description, this.location}) : super._();

  final String? title;
  final String? description;
  final String? location;
}
