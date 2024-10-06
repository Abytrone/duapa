// To parse this JSON data, do
//
//     final supportTopics = supportTopicsFromJson(jsonString);

import 'dart:convert';

List<SupportTopics> supportTopicsFromJson(String str) =>
    List<SupportTopics>.from(
        json.decode(str).map((x) => SupportTopics.fromJson(x)));

String supportTopicsToJson(List<SupportTopics> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SupportTopics {
  SupportTopics({
    required this.id,
    required this.name,
  });

  final String id;
  final String name;

  factory SupportTopics.fromJson(Map<String, dynamic> json) => SupportTopics(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };

  static List<SupportTopics> fromJsonList(List list) {
    return list.map((item) => SupportTopics.fromJson(item)).toList();
  }

  ///this method will prevent the override of toString
  String userAsString() {
    return '#$id $name';
  }

  ///custom comparing function to check if two users are equal
  bool isEqual(SupportTopics model) {
    return id == model.id;
  }

  @override
  String toString() => name;
}
