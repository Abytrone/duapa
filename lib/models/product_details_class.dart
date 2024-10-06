// To parse this JSON data, do
//
//     final productDetails = productDetailsFromJson(jsonString);

import 'dart:convert';

import 'products_model.dart';

ProductDetails productDetailsFromJson(String str) =>
    ProductDetails.fromJson(json.decode(str));

String productDetailsToJson(ProductDetails data) => json.encode(data.toJson());

class ProductDetails {
  final Data data;

  ProductDetails({
    required this.data,
  });

  factory ProductDetails.fromJson(Map<String, dynamic> json) => ProductDetails(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Data {
  final String id;
  final String name;
  final String code;
  final int categoryId;
  final String categoryName;
  final String price;
  final String baseCurrency;
  final double convertedPrice;
  final String convertedCurrencyCode;
  final String discount;
  final String rating;
  final String quantity;
  final String deliveryMode;
  final String picture;
  final int postedBy;
  final String status;
  final KeyHighlights keyHighlights;
  final List<PictureGallery> pictureGallery;
  final List<Product> relatedProducts;

  Data({
    required this.id,
    required this.name,
    required this.code,
    required this.categoryId,
    required this.categoryName,
    required this.price,
    required this.baseCurrency,
    required this.convertedPrice,
    required this.convertedCurrencyCode,
    required this.discount,
    required this.rating,
    required this.quantity,
    required this.deliveryMode,
    required this.picture,
    required this.postedBy,
    required this.status,
    required this.keyHighlights,
    required this.pictureGallery,
    required this.relatedProducts,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        code: json["code"],
        categoryId: json["category_id"],
        categoryName: json["category_name"],
        price: json["price"],
        baseCurrency: json["base_currency"],
        convertedPrice: json["converted_price"]?.toDouble(),
        convertedCurrencyCode: json["converted_currency_code"],
        discount: json["discount"],
        rating: json["rating"],
        quantity: json["quantity"],
        deliveryMode: json["delivery_mode"],
        picture: json["picture"],
        postedBy: json["posted_by"],
        status: json["status"],
        keyHighlights: KeyHighlights.fromJson(json["key_highlights"]),
        pictureGallery: List<PictureGallery>.from(
            json["picture_gallery"].map((x) => PictureGallery.fromJson(x))),
        relatedProducts: List<Product>.from(
            json["related_products"].map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "code": code,
        "category_id": categoryId,
        "category_name": categoryName,
        "price": price,
        "base_currency": baseCurrency,
        "converted_price": convertedPrice,
        "converted_currency_code": convertedCurrencyCode,
        "discount": discount,
        "rating": rating,
        "quantity": quantity,
        "delivery_mode": deliveryMode,
        "picture": picture,
        "posted_by": postedBy,
        "status": status,
        "key_highlights": keyHighlights.toJson(),
        "picture_gallery":
            List<dynamic>.from(pictureGallery.map((x) => x.toJson())),
        "related_products":
            List<dynamic>.from(relatedProducts.map((x) => x.toJson())),
      };
}

class KeyHighlights {
  final String description;

  KeyHighlights({
    required this.description,
  });

  factory KeyHighlights.fromJson(Map<String, dynamic> json) => KeyHighlights(
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "description": description,
      };
}

class PictureGallery {
  final int id;
  final int productId;
  final String pictureName;
  final String picturePath;
  final String url;
  final DateTime createdAt;
  final DateTime updatedAt;

  PictureGallery({
    required this.id,
    required this.productId,
    required this.pictureName,
    required this.picturePath,
    required this.url,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PictureGallery.fromJson(Map<String, dynamic> json) => PictureGallery(
        id: json["id"],
        productId: json["product_id"],
        pictureName: json["picture_name"],
        picturePath: json["picture_path"],
        url: json["url"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "picture_name": pictureName,
        "picture_path": picturePath,
        "url": url,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

// class Product {
//   final String id;
//   final String name;
//   final String baseCurrency;
//   final String price;
//   final double convertedPrice;
//   final String convertedCurrencyCode;
//   final String discount;
//   final String inCart;
//   final String picture;

//   Product({
//     required this.id,
//     required this.name,
//     required this.baseCurrency,
//     required this.price,
//     required this.convertedPrice,
//     required this.convertedCurrencyCode,
//     required this.discount,
//     required this.inCart,
//     required this.picture,
//   });

//   factory Product.fromJson(Map<String, dynamic> json) => Product(
//         id: json["id"],
//         name: json["name"],
//         baseCurrency: json["base_currency"],
//         price: json["price"],
//         convertedPrice: json["converted_price"]?.toDouble(),
//         convertedCurrencyCode: json["converted_currency_code"],
//         discount: json["discount"],
//         inCart: json["in_cart"],
//         picture: json["picture"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "base_currency": baseCurrency,
//         "price": price,
//         "converted_price": convertedPrice,
//         "converted_currency_code": convertedCurrencyCode,
//         "discount": discount,
//         "in_cart": inCart,
//         "picture": picture,
//       };
// }
