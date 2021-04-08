class Comments {
  int id;
  int post_id;
  String name;
  String email;
  String body;

  Comments({
    this.id,
    this.post_id,
    this.name,
    this.email,
    this.body,
  });

  factory Comments.fromJson(Map<String, dynamic> parsedJson) {
    return Comments(
      id: parsedJson['id'],
      post_id: parsedJson['post_id'],
      name: parsedJson['name'],
      email: parsedJson['email'],
      body: parsedJson['body'],
    );
  }

  Map<String, dynamic> toJson() => {
        'post_id': post_id ?? '',
        'name': name ?? '',
        'email': email ?? '',
        'body': body ?? '',
      };
}
