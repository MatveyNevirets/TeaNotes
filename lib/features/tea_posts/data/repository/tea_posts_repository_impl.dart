import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:tea_list/core/errors/errors.dart';
import 'package:tea_list/features/tea_posts/data/model/tea_post_model.dart';
import 'package:tea_list/features/tea_posts/domain/repository/tea_posts_repository.dart';

class TeaPostsRepositoryImpl implements TeaPostsRepository {
  @override
  Future<Either<Failure, List<TeaPostModel>>> fetchPosts() async {
    try {
      // Initialize firestore instance
      final firestoreInstance = FirebaseFirestore.instance;

      // Fetch posts from server
      final posts = await firestoreInstance.collection("tea_posts").get();

      // Fetch all posts in docs format
      final postsList = posts.docs;

      // Here we fetch tea posts list
      final postsModels = postsList.map((post) => TeaPostModel.fromMap(post.data())).toList();

      return Right(postsModels);
    } on Object catch (error, stack) {
      return Left(FetchTeaPostsException(error, stack));
    }
  }
}
