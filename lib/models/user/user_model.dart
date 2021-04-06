class User {
  int id;
  String name;
  String email;
  String gender;
  String status;
  String created_at;
  String updated_at;

  User({
    this.id,
    this.name,
    this.email,
    this.gender,
    this.status,
    this.created_at,
    this.updated_at,
  });

  factory User.fromJson(Map<String, dynamic> parsedJson) {
    return User(
      id: parsedJson['id'],
      name: parsedJson['name'],
      email: parsedJson['email'],
      gender: parsedJson['gender'],
      status: parsedJson['status'],
      created_at: parsedJson['created_at'],
      updated_at: parsedJson['updated_at'],
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'gender': gender,
        'status': status,
        'created_at': created_at,
        'updated_at': updated_at,
      };
}
