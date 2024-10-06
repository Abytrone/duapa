// To parse this JSON cart, do
//
//     final products = productsFromJson(jsonString);

import 'dart:convert';

CartProductsModel cartproductsFromJson(String str) =>
    CartProductsModel.fromJson(json.decode(str));

String cartproductsToJson(CartProductsModel cart) => json.encode(cart.toJson());

class CartProductsModel {
  CartProductsModel({
    required this.cart,
  });

  final List<Product> cart;

  factory CartProductsModel.fromJson(Map<String, dynamic> json) =>
      CartProductsModel(
        cart: List<Product>.from(json["cart"].map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "cart": List<dynamic>.from(cart.map((x) => x.toJson())),
      };
}

class Product {
  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
    required this.discount,
    required this.picture,
    required this.deliveryMode,
  });

  final String id;
  final String name;
  final int price;
  final int quantity;
  final String discount;
  final String picture;
  final String deliveryMode;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        price: int.parse(json["price"]),
        quantity: int.parse(json["quantity"]),
        discount: json["discount"],
        picture: json["picture"],
        deliveryMode: json["delivery_mode"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "quantity": quantity,
        "discount": discount,
        "picture": picture,
        "delivery_mode": deliveryMode,
      };
}
