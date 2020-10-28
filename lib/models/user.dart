class User {
  String id;
  String email;
  String password;

  User({
    this.id,
    this.email,
    this.password,
});

  factory User.fromJson(Map<String, dynamic> json) {
    var data = json['data'];
    return User(
      id: data['id'].toString(),
      email: data['email'] ?? '',
      password: data['pwd']
    );
  }
}