// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'tea_posts_bloc.dart';

@immutable
sealed class TeaPostsState {}

final class TeaPostsInitial extends TeaPostsState {}

class TeaPostsLoading extends TeaPostsState {}

class TeaPostsError extends TeaPostsState {
  String message;
  TeaPostsError({required this.message});
}

class FetchedTeaPosts extends TeaPostsState {
  List<TeaPostEntity> teaPosts;
  FetchedTeaPosts({required this.teaPosts});
}
