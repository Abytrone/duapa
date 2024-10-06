// To parse this JSON data, do
//
//     final serviceProvidersStores = serviceProvidersStoresFromJson(jsonString);

import 'dart:convert';

ServiceProvidersStores serviceProvidersStoresFromJson(String str) =>
    ServiceProvidersStores.fromJson(json.decode(str));

String serviceProvidersStoresToJson(ServiceProvidersStores data) =>
    json.encode(data.toJson());

class ServiceProvidersStores {
  ServiceProvidersStores({
    required this.data,
    required this.message,
  });

  final List<Store>? data;
  final String? message;

  factory ServiceProvidersStores.fromJson(Map<String, dynamic> json) =>
      ServiceProvidersStores(
        data: List<Store>.from(json["data"].map((x) => Store.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Store {
  Store({
    required this.id,
    required this.userID,
    required this.companyName,
    required this.phoneNumber,
    required this.email,
    required this.services,
    required this.profilePicture,
    required this.status,
  });

  final String id;
  final String userID;
  final String companyName;
  final String phoneNumber;
  final String email;
  final String services;
  final String profilePicture;
  final String status;

  factory Store.fromJson(Map<String, dynamic> json) => Store(
        id: json["id"],
        userID: json["user_id"],
        companyName: json["company_name"],
        phoneNumber: json["phone_number"],
        email: json["email"],
        services: json["services"],
        profilePicture: json["profile_picture"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userID,
        "company_name": companyName,
        "phone_number": phoneNumber,
        "email": email,
        "services": services,
        "profile_picture": profilePicture,
        "status": status,
      };
}
