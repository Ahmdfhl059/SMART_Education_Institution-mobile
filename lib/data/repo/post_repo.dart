
import '../../utils/secure_storage.dart';
import '../api/post_api.dart';
import '../models/post.dart';

class PostRepo {
  final PostApi postApi;

  PostRepo({required this.postApi});

  Future<List<Post>> indexPosts() async {
    print("Repo: Fetching Posts...");
    final token = await SecureStorage.getToken();
    final response = await postApi.indexPosts(token: token);
    final data = response;

    final List<Post> posts = data
        .map((postMap) => Post.fromMap(postMap as Map<String, dynamic>))
        .toList();
    return posts;
  }

  Future<Map<String, dynamic>> like({
    required int postId,
  }) async {
    try {
      final response = await postApi.like(
        postId: postId,
      );
      return response;
    } catch (e) {
      print('error in repo :${e.toString()}');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> dislike({
    required int postId,
  }) async {
    try {
      final response = await postApi.disLike(
        postId: postId,
      );
      return response;
    } catch (e) {
      print('error in repo :${e.toString()}');
      rethrow;
    }
  }
}