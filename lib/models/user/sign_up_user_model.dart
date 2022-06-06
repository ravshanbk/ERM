class SignedUpUser {
  SignedUpUser({
    this.id,
    this.name,
    this.email,
    this.isAdmin,
  });

  String? id;
  String? name;
  String? email;
  bool? isAdmin;

  factory SignedUpUser.fromJson(Map<String, dynamic> json) => SignedUpUser(
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

class UserToSignUp {
  String name, email, password;
  bool isAdmin;
  UserToSignUp({
    required this.email,
    required this.isAdmin,
    required this.name,
    required this.password,
  });
  
  Map<String, dynamic> toJson() => {
    
        "password": password,
        "name": name,
        "email": email,
        "isAdmin": isAdmin,
      };
}
