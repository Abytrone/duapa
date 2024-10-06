// To parse this JSON data, do
//
//     final posts = postsFromJson(jsonString);

import 'dart:convert';

Posts postsFromJson(String str) => Posts.fromJson(json.decode(str));

String postsToJson(Posts data) => json.encode(data.toJson());

class Posts {
  Posts({
    required this.data,
  });

  final List<PostData> data;

  factory Posts.fromJson(Map<String, dynamic> json) => Posts(
        data:
            List<PostData>.from(json["data"].map((x) => PostData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class PostData {
  PostData({
    required this.id,
    required this.type,
    required this.attributes,
  });

  final String id;
  final String type;
  final Attributes attributes;

  factory PostData.fromJson(Map<String, dynamic> json) => PostData(
        id: json["id"],
        type: json["type"],
        attributes: Attributes.fromJson(json["attributes"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "attributes": attributes.toJson(),
      };
}

class Attributes {
  Attributes({
    required this.title,
    required this.description,
    required this.picture,
    required this.keywords,
    required this.postedBy,
    required this.likes,
    required this.hasLiked,
    required this.commentsCount,
    required this.comments,
    required this.status,
    required this.createdAt,
  });

  final String title;
  final String description;
  final String picture;
  final dynamic keywords;
  final String postedBy;
  final String likes;
  final String hasLiked;
  final String commentsCount;
  final List<Comment> comments;
  final String status;
  final String createdAt;

  factory Attributes.fromJson(Map<String, dynamic> json) => Attributes(
        title: json["title"],
        description: json["description"],
        picture: json["picture"],
        keywords: json["keywords"],
        postedBy: json["posted_by"],
        likes: json["likes"],
        hasLiked: json["has_liked"],
        commentsCount: json["comments_count"],
        comments: List<Comment>.from(
            json["comments"].map((x) => Comment.fromJson(x))),
        status: json["status"],
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "picture": picture,
        "keywords": keywords,
        "posted_by": postedBy,
        "likes": likes,
        "has_liked": hasLiked,
        "comments_count": commentsCount,
        "comments": List<dynamic>.from(comments.map((x) => x.toJson())),
        "status": status,
        "created_at": createdAt,
      };
}

class Comment {
  Comment({
    required this.userId,
    required this.comment,
    required this.createdAt,
    required this.postedAt,
    required this.user,
  });

  final int? userId;
  final String? comment;
  final DateTime? createdAt;
  final String? postedAt;
  final List<CommentUser>? user;

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        userId: json["user_id"],
        comment: json["comment"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        postedAt: json["posted_at"],
        user: json["user"] == null
            ? null
            : List<CommentUser>.from(
                json["user"].map((x) => CommentUser.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "comment": comment,
        "created_at": createdAt!.toIso8601String(),
        "posted_at": postedAt,
        "user": List<dynamic>.from(user!.map((x) => x.toJson())),
      };
}

class CommentUser {
  CommentUser({
    required this.id,
    required this.username,
    required this.profilePhotoUrl,
  });

  final int id;
  final String username;
  final String profilePhotoUrl;

  factory CommentUser.fromJson(Map<String, dynamic> json) => CommentUser(
        id: json["id"],
        username: json["username"],
        profilePhotoUrl: json["profile_photo_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "profile_photo_url": profilePhotoUrl,
      };
}
