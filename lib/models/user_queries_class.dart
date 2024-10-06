// To parse this JSON data, do
//
//     final userQueriesClass = userQueriesClassFromJson(jsonString);

import 'dart:convert';

UserQueriesClass userQueriesClassFromJson(String str) =>
    UserQueriesClass.fromJson(json.decode(str));

String userQueriesClassToJson(UserQueriesClass data) =>
    json.encode(data.toJson());

class UserQueriesClass {
  final List<Query> data;

  UserQueriesClass({
    required this.data,
  });

  factory UserQueriesClass.fromJson(Map<String, dynamic> json) =>
      UserQueriesClass(
        data: List<Query>.from(json["data"].map((x) => Query.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Query {
  final int id;
  final String title;
  final String description;
  final String response;
  final String extensionOfficerName;
  final DateTime? responseDate;

  Query({
    required this.id,
    required this.title,
    required this.description,
    required this.response,
    required this.extensionOfficerName,
    required this.responseDate,
  });

  factory Query.fromJson(Map<String, dynamic> json) => Query(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        response: json["response"],
        extensionOfficerName: json["extension_officer_name"],
        responseDate: json["response_date"] == null
            ? null
            : DateTime.parse(json["response_date"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "response": response,
        "extension_officer_name": extensionOfficerName,
        "response_date": responseDate?.toIso8601String(),
      };
}
