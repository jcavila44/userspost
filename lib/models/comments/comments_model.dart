import 'package:userspost/models/post/post_model.dart';

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

  factory Comments.fromJson(Map<String, dynamic> parsedJson) {
    return Comments(
      id: parsedJson['id'],
      post: parsedJson['post'],
      name: parsedJson['name'],
      email: parsedJson['email'],
      body: parsedJson['body'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id ?? '',
        'post': post ?? '',
        'name': name ?? '',
        'email': email ?? '',
        'body': body ?? '',
      };
}
