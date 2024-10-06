// To parse this JSON data, do
//
//     final extensionOfficers = extensionOfficersFromJson(jsonString);

import 'dart:convert';

ExtensionOfficers extensionOfficersFromJson(String str) =>
    ExtensionOfficers.fromJson(json.decode(str));

String extensionOfficersToJson(ExtensionOfficers data) =>
    json.encode(data.toJson());

class ExtensionOfficers {
  final List<Officer> data;

  ExtensionOfficers({
    required this.data,
  });

  factory ExtensionOfficers.fromJson(Map<String, dynamic> json) =>
      ExtensionOfficers(
        data: List<Officer>.from(json["data"].map((x) => Officer.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Officer {
  final int id;
  final int userID;
  final String fullname;
  final String services;
  final String profilePicture;
  final String phoneNumber;

  Officer({
    required this.id,
    required this.userID,
    required this.fullname,
    required this.services,
    required this.profilePicture,
    required this.phoneNumber,
  });

  factory Officer.fromJson(Map<String, dynamic> json) => Officer(
        id: json["id"],
        userID: json["user_id"],
        fullname: json["fullname"],
        services: json["services"],
        profilePicture: json["profile_picture"],
        phoneNumber: json["phone_number"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userID,
        "fullname": fullname,
        "services": services,
        "profile_picture": profilePicture,
        "phone_number": phoneNumber,
      };
}
