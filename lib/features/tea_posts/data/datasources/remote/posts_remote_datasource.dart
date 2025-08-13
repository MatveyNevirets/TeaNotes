import 'package:dartz/dartz.dart';
import 'package:tea_list/core/errors/errors.dart';
import 'package:tea_list/features/tea_posts/data/model/tea_post_model.dart';

abstract class PostsRemoteDatasource {
  Future<Either<Failure, List<TeaPostModel>>> fetchPosts();
}
