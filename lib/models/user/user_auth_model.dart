class UserAuth {
  UserAuth({
    this.id,
    this.name,
    this.email,
    this.password,
  });

  String? id;
  String? name;
  String? email;
  String? password;

  factory UserAuth.fromJson(Map<String, dynamic> json) => UserAuth(
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "email": email,
        "password": password,
      };
}
