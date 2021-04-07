import 'package:userspost/models/posts/posts_model.dart';

class Comments {
  int id;
  Post post;
  String name;
  String email;
  String body;

  Comments({
    this.id,
    this.post,
    this.name,
    this.email,
    this.body,
  });

  factory Comments.fromJson(Map<String, dynamic> json) => Comments(
        id: json['id'] ?? 0,
        post: json['post'] ?? '',
        name: json['name'] ?? '',
        email: json['email'] ?? '',
        body: json['body'] ?? '',
      );

  Map<String, dynamic> toJson() {
    var map = {
      'id': id ?? '',
      'post': post ?? '',
      'name': name ?? '',
      'email': email ?? '',
      'body': body ?? '',
    };

    if (map['id'] != null) map['id'] = id ?? '';

    return map;
  }
}
