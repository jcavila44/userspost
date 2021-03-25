class User {
  int id;
  String name;
  String email;
  String gender;
  String status;
  // ignore: non_constant_identifier_names
  String created_at;
  // ignore: non_constant_identifier_names
  String updated_at;

  User({
    this.id,
    this.name,
    this.email,
    this.gender,
    this.status,
    // ignore: non_constant_identifier_names
    this.created_at,
    // ignore: non_constant_identifier_names
    this.updated_at,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'] ?? 0,
        name: json['name'] ?? '',
        email: json['email'] ?? '',
        gender: json['gender'] ?? '',
        status: json['status'] ?? '',
        created_at: json['created_at'] ?? '',
        updated_at: json['updated_at'] ?? '',
      );

  Map<String, dynamic> toJson() {
    var map = {
      'name': this.name ?? '',
      'email': this.email ?? '',
      'gender': this.gender ?? '',
      'status': this.status ?? '',
      'created_at': this.created_at ?? '',
      'updated_at': this.updated_at ?? '',
    };

    if (map['id'] != null) map['id'] = this.id ?? '';

    return map;
  }
}
