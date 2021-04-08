class Comments {
  int id;
  int post_id;
  String name;
  String email;
  String body;
  String created_at;
  String updated_at;

  Comments({
    this.id,
    this.post_id,
    this.name,
    this.email,
    this.body,
    this.created_at,
    this.updated_at,
  });

  factory Comments.fromJson(Map<String, dynamic> parsedJson) {
    return Comments(
      id: parsedJson['id'],
      post_id: parsedJson['post_id'],
      name: parsedJson['name'],
      email: parsedJson['email'],
      body: parsedJson['body'],
      created_at: parsedJson['created_at'],
      updated_at: parsedJson['updated_at'],
    );
  }

  Map<String, dynamic> toJson() => {
        'post_id': post_id ?? '',
        'name': name ?? '',
        'email': email ?? '',
        'body': body ?? '',
        'created_at': created_at ?? '',
        'updated_at': updated_at ?? '',
      };
}
