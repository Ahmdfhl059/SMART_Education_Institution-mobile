part of 'post_cubit.dart';

enum PostStatus { initial, loading, loaded, error }
enum LikesStatus { non, like, dislike }

class PostState extends Equatable {
  final PostStatus status;
  final Post post;
  final List<Post> posts;
  final LikesStatus likesStatus;
  final String error;

  const PostState({
    required this.status,
    required this.post,
    required this.posts,
    required this.likesStatus,
    required this.error,
  });

  factory PostState.initial() => PostState(
    status: PostStatus.initial,
    post: Post.initial(),
    posts: const [],
    likesStatus: LikesStatus.non,
    error: '',
  );

  PostState copyWith({
    PostStatus? status,
    Post? post,
    List<Post>? posts,
    LikesStatus? likesStatus,
    String? error,
  }) {
    return PostState(
      status: status ?? this.status,
      post: post ?? this.post,
      posts: posts ?? this.posts,
      likesStatus: likesStatus ?? this.likesStatus,
      error: error ?? this.error,
    );
  }

  @override
  List<Object> get props => [status, post, posts, likesStatus, error];
}