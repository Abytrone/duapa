// To parse this JSON data, do
//
//     final ads = adsFromJson(jsonString);

import 'dart:convert';

Ads adsFromJson(String str) => Ads.fromJson(json.decode(str));

String adsToJson(Ads data) => json.encode(data.toJson());

class Ads {
  Ads({
    required this.data,
  });

  final List<Dater> data;

  factory Ads.fromJson(Map<String, dynamic> json) => Ads(
        data: List<Dater>.from(json["data"].map((x) => Dater.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Dater {
  Dater({
    required this.id,
    required this.title,
    required this.description,
    required this.url,
    required this.picturePath,
    required this.pictureName,
    required this.pictureType,
    required this.postedBy,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final String title;
  final String description;
  final String url;
  final String picturePath;
  final String pictureName;
  final String pictureType;
  final String postedBy;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory Dater.fromJson(Map<String, dynamic> json) => Dater(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        url: json["url"],
        picturePath: json["picture_path"],
        pictureName: json["picture_name"],
        pictureType: json["picture_type"],
        postedBy: json["posted_by"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "url": url,
        "picture_path": picturePath,
        "picture_name": pictureName,
        "picture_type": pictureType,
        "posted_by": postedBy,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
