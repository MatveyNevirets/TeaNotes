import 'package:dartz/dartz.dart';
import 'package:tea_list/core/errors/errors.dart';
import 'package:tea_list/features/tea_posts/domain/entity/tea_post_entity.dart';

abstract class TeaPostsRepository {
  Future<Either<Failure, List<TeaPostEntity>>> fetchPosts();
}
