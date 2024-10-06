// To parse this JSON data, do
//
//     final galleryVideo = galleryVideoFromJson(jsonString);

import 'dart:convert';

List<GalleryVideo> galleryVideoFromJson(String str) => List<GalleryVideo>.from(
    json.decode(str).map((x) => GalleryVideo.fromJson(x)));

String galleryVideoToJson(List<GalleryVideo> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GalleryVideo {
  GalleryVideo({
    required this.id,
    required this.title,
    required this.description,
    required this.url,
    required this.code,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final String title;
  final String description;
  final String url;
  final String code;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory GalleryVideo.fromJson(Map<String, dynamic> json) => GalleryVideo(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        url: json["url"],
        code: json["code"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "url": url,
        "code": code,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
