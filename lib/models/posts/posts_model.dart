import 'package:userspost/models/user/user_model.dart';

class Post {
  int id;
  String title;
  String body;
  User user;

  Post({this.id, this.body, this.title, this.user});

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json['id'] ?? 0,
        title: json['title'] ?? '',
        body: json['body'] ?? '',
        user: json['user'] ?? '',
      );

  Map<String, dynamic> toJson() {
    var map = {
      'id': this.id ?? '',
      'title': this.title ?? '',
      'body': this.body ?? '',
      'user': this.user ?? '',
    };

    if (map['id'] != null) map['id'] = this.id ?? '';

    return map;
  }
}
