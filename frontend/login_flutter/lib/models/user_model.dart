// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  final int id;
  final String username;
  final String password;
  final String name;
  final String email;

  UserModel({
    required this.id,
    required this.username,
    required this.password,
    required this.name,
    required this.email,
  });
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"],
      username: json["username"],
      password: json["password"],
      name: json["name"],
      email: json["email"],
    );
  }

  @override
  String toString() {
    return 'UserModel(id: $id, username: $username, password: $password, name: $name, email: $email)';
  }
}
