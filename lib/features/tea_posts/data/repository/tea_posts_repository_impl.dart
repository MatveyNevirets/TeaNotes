import 'package:dartz/dartz.dart';
import 'package:tea_list/core/errors/errors.dart';
import 'package:tea_list/features/tea_posts/data/datasources/remote/posts_remote_datasource.dart';
import 'package:tea_list/features/tea_posts/data/model/tea_post_model.dart';
import 'package:tea_list/features/tea_posts/domain/repository/tea_posts_repository.dart';

class TeaPostsRepositoryImpl implements TeaPostsRepository {
  final PostsRemoteDatasource postsRemoteDatasource;
  TeaPostsRepositoryImpl({required this.postsRemoteDatasource});

  @override
  Future<Either<Failure, List<TeaPostModel>>> fetchPosts() async {
    try {
      final result = await postsRemoteDatasource.fetchPosts();

      return result;
    } on Object catch (error, stack) {
      return Left(FetchTeaPostsException(error, stack));
    }
  }
}
