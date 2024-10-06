// To parse this JSON data, do
//
//     final shippingAddressModel = shippingAddressModelFromJson(jsonString);

import 'dart:convert';

List<ShippingAddressModel> shippingAddressModelFromJson(String str) =>
    List<ShippingAddressModel>.from(
        json.decode(str).map((x) => ShippingAddressModel.fromJson(x)));

String shippingAddressModelToJson(List<ShippingAddressModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ShippingAddressModel {
  final int id;
  final int userId;
  final dynamic orderId;
  final String? email;
  final String phone;
  final String address;
  final String city;
  final String region;
  final String country;
  final int isDefault;
  final DateTime createdAt;
  final DateTime updatedAt;

  ShippingAddressModel({
    required this.id,
    required this.userId,
    this.orderId,
    this.email,
    required this.phone,
    required this.address,
    required this.city,
    required this.region,
    required this.country,
    required this.isDefault,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ShippingAddressModel.fromJson(Map<String, dynamic> json) =>
      ShippingAddressModel(
        id: json["id"],
        userId: json["user_id"],
        orderId: json["order_id"],
        email: json["email"],
        phone: json["phone"],
        address: json["address"],
        city: json["city"],
        region: json["region"],
        country: json["country"],
        isDefault: json["is_default"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "order_id": orderId,
        "email": email,
        "phone": phone,
        "address": address,
        "city": city,
        "region": region,
        "country": country,
        "is_default": isDefault,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
