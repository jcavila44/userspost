class Post {
  int id;
  int user_id;
  String title;
  String body;
  String created_at;
  String updated_at;

  Post({
    this.id,
    this.user_id,
    this.title,
    this.body,
    this.created_at,
    this.updated_at,
  });

  factory Post.fromJson(Map<String, dynamic> parsedJson) {
    return Post(
      id: parsedJson['id'],
      user_id: parsedJson['user_id'],
      title: parsedJson['title'],
      body: parsedJson['body'],
      created_at: parsedJson['created_at'],
      updated_at: parsedJson['updated_at'],
    );
  }

  Map<String, dynamic> toJson() => {
        'user_id': user_id,
        'title': title,
        'body': body,
        'created_at': created_at,
        'updated_at': updated_at,
      };
}
