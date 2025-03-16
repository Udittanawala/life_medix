import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  bool status;
  String message;
  User user;

  UserModel({
    required this.status,
    required this.message,
    required this.user,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        status: json["status"],
        message: json["message"],
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "user": user.toJson(),
      };
}

class User {
  String userId;
  String userName;
  String userPass;
  String userEmail;
  String userContect;
  String userAddress;
  String userImg;
  String status;

  User({
    required this.userId,
    required this.userName,
    required this.userPass,
    required this.userEmail,
    required this.userContect,
    required this.userAddress,
    required this.userImg,
    required this.status,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        userId: json["user_id"],
        userName: json["user_name"],
        userPass: json["user_pass"],
        userEmail: json["user_email"],
        userContect: json["user_contect"],
        userAddress: json["user_address"],
        userImg: json["user_img"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "user_name": userName,
        "user_pass": userPass,
        "user_email": userEmail,
        "user_contect": userContect,
        "user_address": userAddress,
        "user_img": userImg,
        "status": status,
      };
}
