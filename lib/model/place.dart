import 'dart:convert';

PlaceModel placeModelFromJson(String str) =>
    PlaceModel.fromJson(json.decode(str));

String placeModelToJson(PlaceModel data) => json.encode(data.toJson());

class PlaceModel {
  PlaceModel({
    required this.statusCode,
    required this.message,
    this.data,
  });

  int statusCode;
  String message;
  Data? data;

  factory PlaceModel.fromJson(Map<String, dynamic> json) => PlaceModel(
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
    this.header,
    this.content,
  });

  Header? header;
  List<Content>? content;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        header: json["header"] != null ? Header.fromJson(json["header"]) : null,
        content: json["content"] != null
            ? List<Content>.from(
                json["content"].map((x) => Content.fromJson(x)))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "header": header != null ? header!.toJson() : null,
        "content": content != null
            ? List<dynamic>.from(content!.map((x) => x.toJson()))
            : null,
      };
}

class Content {
  Content({
    this.id,
    this.title,
    this.content,
    this.type,
    this.image,
    this.media,
  });

  int? id;
  String? title;
  String? content;
  String? type;
  String? image;
  List<String>? media;

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        id: json["id"],
        title: json["title"],
        content: json["content"],
        type: json["type"],
        image: json["image"],
        media: json["media"] != null
            ? List<String>.from(json["media"].map((x) => x))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "content": content,
        "type": type,
        "image": image,
        "media":
            media != null ? List<dynamic>.from(media!.map((x) => x)) : null,
      };
}

class Header {
  Header({
    this.title,
    this.subtitle,
  });

  String? title;
  String? subtitle;

  factory Header.fromJson(Map<String, dynamic> json) => Header(
        title: json["title"],
        subtitle: json["subtitle"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "subtitle": subtitle,
      };
}
