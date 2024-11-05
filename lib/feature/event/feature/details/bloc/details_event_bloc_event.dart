sealed class DetailsEventBlocEvent {}

final class DetailsEventToggleEditMode extends DetailsEventBlocEvent {}

final class DetailsEventSaveEvent extends DetailsEventBlocEvent {}

final class DetailsEventToggleFavorite extends DetailsEventBlocEvent {}

final class DetailsEventUpdateText extends DetailsEventBlocEvent {
  final String? title;
  final String? description;
  final String? location;

  DetailsEventUpdateText({this.title, this.description, this.location});
}
