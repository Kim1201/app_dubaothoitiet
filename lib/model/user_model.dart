
class User {
  String id;
  String userId;
  String email;
  String name;
  String givenName;
  String familyName;
  String nickname;
  DateTime createdAt;
  DateTime updatedAt;

  User({
    required this.id,
    required this.userId,
    required this.email,
    required this.name,
    required this.givenName,
    required this.familyName,
    required this.nickname,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["_id"],
    userId: json["user_id"],
    email: json["email"],
    name: json["name"],
    givenName: json["given_name"],
    familyName: json["family_name"],
    nickname: json["nickname"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "user_id": userId,
    "email": email,
    "name": name,
    "given_name": givenName,
    "family_name": familyName,
    "nickname": nickname,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
