part of 'favorite_bloc.dart';

@immutable
sealed class FavoriteEvent {}

class TryFetchFavoriteTeasEvent extends FavoriteEvent {}
