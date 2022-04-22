import 'dart:convert';

GalleryModel galleryModelFromJson(String str) =>
    GalleryModel.fromJson(json.decode(str));

String galleryModelToJson(GalleryModel data) => json.encode(data.toJson());

class GalleryModel {
  GalleryModel({
    required this.statusCode,
    required this.message,
    this.data,
  });

  int statusCode;
  String message;
  List<Gallery>? data;

  factory GalleryModel.fromJson(Map<String, dynamic> json) => GalleryModel(
        statusCode: json["status_code"],
        message: json["message"],
        data: json["data"] != null
            ? List<Gallery>.from(json["data"].map((x) => Gallery.fromJson(x)))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "message": message,
        "data": data != null
            ? List<dynamic>.from(data!.map((x) => x.toJson()))
            : null,
      };
}

class Gallery {
  Gallery({
    this.caption,
    this.thumbnail,
    this.image,
  });

  String? caption;
  String? thumbnail;
  String? image;

  factory Gallery.fromJson(Map<String, dynamic> json) => Gallery(
        caption: json["caption"],
        thumbnail: json["thumbnail"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "caption": caption,
        "thumbnail": thumbnail,
        "image": image,
      };
}
