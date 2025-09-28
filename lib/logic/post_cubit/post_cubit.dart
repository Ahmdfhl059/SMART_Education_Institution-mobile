import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/post.dart';
import '../../data/repo/post_repo.dart';

part 'post_state.dart';

class PostCubit extends Cubit<PostState> {
  final PostRepo postRepo;

  PostCubit({required this.postRepo}) : super(PostState.initial()) {
     indexPosts();
  }

  Future<void> indexPosts() async {
    emit(state.copyWith(status: PostStatus.loading));
    try {
      final List<Post> posts = await postRepo.indexPosts();
      emit(state.copyWith(status: PostStatus.loaded, posts: posts));
    } catch (e) {
      emit(state.copyWith(status: PostStatus.error, error: e.toString()));
    }
  }

  void setPost(Post post) {
    emit(state.copyWith(status: PostStatus.loaded, post: post, likesStatus: LikesStatus.non));
  }

  void likePost({required Post post}) {
    final p = post;

    switch (state.likesStatus) {
      case LikesStatus.non:
        emit(state.copyWith(
          post: p.copyWith(likes: p.likes + 1),
          likesStatus: LikesStatus.like,
        ));

        _persistReaction(p.postId, isLike: true);
        break;

      case LikesStatus.like:
        break;

      case LikesStatus.dislike:
        emit(state.copyWith(
          post: p.copyWith(
            likes: p.likes + 1,
            dislikes: (p.dislikes > 0) ? p.dislikes - 1 : 0,
          ),
          likesStatus: LikesStatus.like,
        ));
        _persistReaction(p.postId, isLike: true);
        break;
    }
  }

  void dislikePost({required Post post}) {
    final p = post;

    switch (state.likesStatus) {
      case LikesStatus.non:
        emit(state.copyWith(
          post: p.copyWith(dislikes: p.dislikes + 1),
          likesStatus: LikesStatus.dislike,
        ));
        _persistReaction(p.postId, isLike: false);
        break;

      case LikesStatus.like:
        emit(state.copyWith(
          post: p.copyWith(
            likes: (p.likes > 0) ? p.likes - 1 : 0,
            dislikes: p.dislikes + 1,
          ),
          likesStatus: LikesStatus.dislike,
        ));
        _persistReaction(p.postId, isLike: false);
        break;

      case LikesStatus.dislike:
        break;
    }
  }

  Future<void> _persistReaction(int postId, {required bool isLike}) async {
    try {
      if (isLike) {
        await postRepo.like(postId: postId);
      } else {
        await postRepo.dislike(postId: postId);
      }
    } catch (_) {
    }
  }
}