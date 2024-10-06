// To parse this JSON data, do
//
//     final products = productsFromJson(jsonString);

import 'dart:convert';

Products productsFromJson(String str) => Products.fromJson(json.decode(str));

String productsToJson(Products data) => json.encode(data.toJson());

class Products {
  Products({
    required this.data,
    required this.message,
  });

  final List<Product>? data;
  final String? message;

  factory Products.fromJson(Map<String, dynamic> json) => Products(
        data: json["data"] == null
            ? null
            : List<Product>.from(json["data"].map((x) => Product.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Product {
  Product({
    required this.id,
    required this.name,
    required this.baseCurrency,
    required this.price,
    required this.convertedPrice,
    required this.convertedCurrencyCode,
    required this.discount,
    required this.inCart,
    required this.picture,
  });

  final String id;
  final String name;
  final String baseCurrency;
  final double price;
  final double convertedPrice;
  final String convertedCurrencyCode;
  final String discount;
  final String inCart;
  final String picture;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        baseCurrency: json["base_currency"],
        price: double.parse(json["price"]),
        convertedPrice: double.parse(json["converted_price"]),
        convertedCurrencyCode: json["converted_currency_code"],
        discount: json["discount"],
        inCart: json["in_cart"],
        picture: json["picture"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "base_currency": baseCurrency,
        "price": price,
        "converted_price": convertedPrice,
        "converted_currency_code": convertedCurrencyCode,
        "discount": discount,
        "in_cart": inCart,
        "picture": picture,
      };
}
