part of 'tea_posts_bloc.dart';

@immutable
sealed class TeaPostsEvent {}

class TryFetchPostsEvent extends TeaPostsEvent {}
