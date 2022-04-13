
class User {
    User({
        this.id,
        this.name,
        this.email,
        this.isAdmin,
    });

    String? id;
    String? name;
    String? email;
    bool? isAdmin;

    factory User.fromJson(Map<String, dynamic> json) => User(
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
