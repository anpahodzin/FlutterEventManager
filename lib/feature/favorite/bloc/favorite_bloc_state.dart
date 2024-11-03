import 'package:equatable/equatable.dart';
import 'package:flutter_event_manager/feature/event_list/domain/model/event.dart';

class FavoriteBlocState extends Equatable {
  const FavoriteBlocState({
    required this.favorites,
  });

  final List<Event> favorites;

  @override
  List<Object?> get props => [favorites];

  FavoriteBlocState copyWith({List<Event>? favorites}) {
    return FavoriteBlocState(
      favorites: favorites ?? List.from(this.favorites),
    );
  }
}
