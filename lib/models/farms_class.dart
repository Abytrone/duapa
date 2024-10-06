// To parse this JSON data, do
//
//     final farms = farmsFromJson(jsonString);

import 'dart:convert';

List<Farms> farmsFromJson(String str) =>
    List<Farms>.from(json.decode(str).map((x) => Farms.fromJson(x)));

String farmsToJson(List<Farms> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Farms {
  Farms({
    required this.id,
    required this.numberOfAcres,
    required this.farmWorth,
    required this.farmLocation,
    required this.numberOfAcresProduced,
    required this.productsGrown,
    required this.description,
    required this.farmPicture,
    required this.picturePath,
    required this.pictureName,
    required this.longitude,
    required this.latitude,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final String numberOfAcres;
  final String farmWorth;
  final String farmLocation;
  final String numberOfAcresProduced;
  final String productsGrown;
  final String description;
  final String farmPicture;
  final String picturePath;
  final String pictureName;
  final String longitude;
  final String latitude;
  final int userId;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory Farms.fromJson(Map<String, dynamic> json) => Farms(
        id: json["id"],
        numberOfAcres: json["number_of_acres"],
        farmWorth: json["farm_worth"],
        farmLocation: json["farm_location"],
        numberOfAcresProduced: json["number_of_acres_produced"],
        productsGrown: json["products_grown"],
        description: json["description"],
        farmPicture: json["farm_picture"],
        picturePath: json["picture_path"],
        pictureName: json["picture_name"],
        longitude: json["longitude"],
        latitude: json["latitude"],
        userId: json["user_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "number_of_acres": numberOfAcres,
        "farm_worth": farmWorth,
        "farm_location": farmLocation,
        "number_of_acres_produced": numberOfAcresProduced,
        "farm_picture": farmPicture,
        "picture_path": picturePath,
        "picture_name": pictureName,
        "user_id": userId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
