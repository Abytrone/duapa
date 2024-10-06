// To parse this JSON data, do
//
//     final officerQueryClass = officerQueryClassFromJson(jsonString);

import 'dart:convert';

OfficerQueryClass officerQueryClassFromJson(String str) =>
    OfficerQueryClass.fromJson(json.decode(str));

String officerQueryClassToJson(OfficerQueryClass data) =>
    json.encode(data.toJson());

class OfficerQueryClass {
  final List<OfficerQuery> data;

  OfficerQueryClass({
    required this.data,
  });

  factory OfficerQueryClass.fromJson(Map<String, dynamic> json) =>
      OfficerQueryClass(
        data: List<OfficerQuery>.from(
            json["data"].map((x) => OfficerQuery.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class OfficerQuery {
  final int id;
  final String title;
  final String description;
  final String response;
  final String extensionOfficerName;
  final DateTime? responseDate;

  OfficerQuery({
    required this.id,
    required this.title,
    required this.description,
    required this.response,
    required this.extensionOfficerName,
    required this.responseDate,
  });

  factory OfficerQuery.fromJson(Map<String, dynamic> json) => OfficerQuery(
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
