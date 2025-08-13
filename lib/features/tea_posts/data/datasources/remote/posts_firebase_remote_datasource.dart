import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:tea_list/core/errors/errors.dart';
import 'package:tea_list/features/tea_posts/data/datasources/remote/posts_remote_datasource.dart';
import 'package:tea_list/features/tea_posts/data/model/tea_post_model.dart';

class PostsFirebaseRemoteDatasource implements PostsRemoteDatasource {
  final FirebaseFirestore firestore;
  PostsFirebaseRemoteDatasource({required this.firestore});

  @override
  Future<Either<Failure, List<TeaPostModel>>> fetchPosts() async {
    try {
      // Fetch posts from server
      final posts = await firestore.collection("tea_posts").get();

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