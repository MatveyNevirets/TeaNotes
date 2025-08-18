part of 'favorite_bloc.dart';

@immutable
sealed class FavoriteState {}

final class FavoriteInitial extends FavoriteState {}

class FavoriteTeasSuccessfulFetchedState extends FavoriteState {
  final List<TeaModel> teas;

  FavoriteTeasSuccessfulFetchedState({required this.teas});
}

class FavoriteErrorState extends FavoriteState {}

class FavoriteLoadingState extends FavoriteState {}