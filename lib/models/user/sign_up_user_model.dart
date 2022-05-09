class SignUpUser {
  SignUpUser({
    this.id,
    this.name,
    this.email,
    this.isAdmin,
  });

  String? id;
  String? name;
  String? email;
  bool? isAdmin;

  factory SignUpUser.fromJson(Map<String, dynamic> json) => SignUpUser(
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        isAdmin: json["isAdmin"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "email": email,
        "isAdmin": isAdmin,
      };
}
