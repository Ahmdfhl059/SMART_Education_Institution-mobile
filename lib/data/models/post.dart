
class Post {
  final int postId;
  final String title;
  final String description;
  final int likes;
  final int dislikes;
  final String imageUrl;
  final DateTime createdAt;

  Post({
    required this.postId,
    required this.title,
    required this.description,
     required this.likes,
     required this.dislikes,
    required this.imageUrl,
    DateTime? createdAt,
  }): createdAt = createdAt ?? DateTime.now();


  Map<String, dynamic> toMap() {
    return {
      'post_id': this.postId,
      'title': this.title,
      'description': this.description,
      'likes_count': this.likes,
      'dislikes_count': this.dislikes,
      'image_url': this.imageUrl,
    };
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      postId: map['id'] ?? -1000,
      title: map['title'] ?? "empty data",
      description: map['description'] ?? "empty data",
      likes: map['likes_count'] ,
      dislikes: map['dislikes_count'] ,
      imageUrl: map['image_url'] ?? '',
    );
  }


  factory Post.initial() =>
      Post(postId: -1, title: 'empty data', description: 'empty data', likes: 0,dislikes: 0,imageUrl: '');

  Post copyWith({
    int? postId,
    String? title,
    String? description,
    int? likes,
    int? dislikes,
    String? imageUrl,
    DateTime? createdAt,
  }) {
    return Post(
      postId: postId ?? this.postId,
      title: title ?? this.title,
      description: description ?? this.description,
      likes: likes ?? this.likes,
      dislikes: dislikes ?? this.dislikes,
      imageUrl: imageUrl ?? this.imageUrl,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
