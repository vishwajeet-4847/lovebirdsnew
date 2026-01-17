import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  bool status;
  String message;
  bool signUp;
  User user;

  LoginModel({
    required this.status,
    required this.message,
    required this.signUp,
    required this.user,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        status: json["status"],
        message: json["message"],
        signUp: json["signUp"],
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "signUp": signUp,
        "user": user.toJson(),
      };
}

class User {
  String id;
  int loginType;
  String name;
  String image;
  String fcmToken;
  String lastlogin;

  User({
    required this.id,
    required this.loginType,
    required this.name,
    required this.image,
    required this.fcmToken,
    required this.lastlogin,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        loginType: json["loginType"],
        name: json["name"],
        image: json["image"],
        fcmToken: json["fcmToken"],
        lastlogin: json["lastlogin"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "loginType": loginType,
        "name": name,
        "image": image,
        "fcmToken": fcmToken,
        "lastlogin": lastlogin,
      };
}
