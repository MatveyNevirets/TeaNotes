import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tea_list/core/models/tea_model.dart';
import 'package:tea_list/features/favorite/domain/favorite_repository.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final FavoriteRepository favoriteRepository;

  FavoriteBloc({required this.favoriteRepository}) : super(FavoriteInitial()) {
    on<TryFetchFavoriteTeasEvent>(_tryFetchFavoriteTeas);
  }

  Future<void> _tryFetchFavoriteTeas(TryFetchFavoriteTeasEvent event, Emitter<FavoriteState> emit) async {
    emit(FavoriteLoadingState());

    try {
      final result = await favoriteRepository.fetchFavoriteTeas();

      result.fold(
        (fail) {
          log("Error at FavoriteBloc ${fail.runtimeType.toString()} Error: ${fail.error} StackTrace: ${fail.stack}");
          emit(FavoriteErrorState());
        },
        (success) {
          emit(FavoriteTeasSuccessfulFetchedState(teas: success));
        },
      );
    } on Object catch (error, stack) {
      throw Exception("Error at FavoriteBloc. Error: $error, StackTrace: $stack");
    }
  }
}
