import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tea_list/features/tea_posts/domain/entity/tea_post_entity.dart';
import 'package:tea_list/features/tea_posts/domain/repository/tea_posts_repository.dart';

part 'tea_posts_event.dart';
part 'tea_posts_state.dart';

class TeaPostsBloc extends Bloc<TeaPostsEvent, TeaPostsState> {
  final TeaPostsRepository _teaPostsRepository;

  TeaPostsBloc(this._teaPostsRepository) : super(TeaPostsInitial()) {
    on<TryFetchPostsEvent>(_fetchPosts);
  }

  Future<void> _fetchPosts(TryFetchPostsEvent event, Emitter<TeaPostsState> emit) async {
    emit(TeaPostsLoading());
    try {
      final result = await _teaPostsRepository.fetchPosts();

      result.fold(
        (error) {
          emit(TeaPostsError(message: "Неудалось получить чайные посты"));
        },
        (success) {
          emit(FetchedTeaPosts(teaPosts: success));
        },
      );
    } on Object catch (error, stack) {
      throw Exception("Error into Posts BLoC. Error: $error. StackTrace: $stack");
    }
  }
}
