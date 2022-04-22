import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    required this.statusCode,
    required this.message,
    this.data,
  });

  int statusCode;
  String message;
  Data? data;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        statusCode: json["status_code"],
        message: json["message"],
        data: json["data"] != null ? Data.fromJson(json["data"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "message": message,
        "data": data != null ? data!.toJson() : null,
      };
}

class Data {
  Data({
    this.id,
    this.username,
    this.fullname,
    this.email,
    this.phone,
    this.avatar,
  });

  int? id;
  String? username;
  String? fullname;
  String? email;
  String? phone;
  String? avatar;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        username: json["username"],
        fullname: json["fullname"],
        email: json["email"],
        phone: json["phone"],
        avatar: json["avatar"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "fullname": fullname,
        "email": email,
        "phone": phone,
        "avatar": avatar,
      };
}
