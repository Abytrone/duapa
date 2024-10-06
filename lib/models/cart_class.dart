// To parse this JSON data, do
//
//     final cart = cartFromJson(jsonString);

import 'dart:convert';

Cart cartFromJson(String str) => Cart.fromJson(json.decode(str));

String cartToJson(Cart data) => json.encode(data.toJson());

class Cart {
  final bool status;
  final List<CartProduct> products;
  final Totals totals;

  Cart({
    required this.status,
    required this.products,
    required this.totals,
  });

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        status: json["status"],
        products: List<CartProduct>.from(
            json["products"].map((x) => CartProduct.fromJson(x))),
        totals: Totals.fromJson(json["totals"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
        "totals": totals.toJson(),
      };
}

class CartProduct {
  final String cartId;
  final String productId;
  final String productName;
  final String discount;
  final String discountedPrice;
  final String price;
  final double convertedPrice;
  final String convertedCurrencyCode;
  final String quantity;
  final String totalPrice;
  final double totalConvertedPrice;
  final String picture;

  CartProduct({
    required this.cartId,
    required this.productId,
    required this.productName,
    required this.discount,
    required this.discountedPrice,
    required this.price,
    required this.convertedPrice,
    required this.convertedCurrencyCode,
    required this.quantity,
    required this.totalPrice,
    required this.totalConvertedPrice,
    required this.picture,
  });

  factory CartProduct.fromJson(Map<String, dynamic> json) => CartProduct(
        cartId: json["cart_id"],
        productId: json["product_id"],
        productName: json["product_name"],
        discount: json["discount"],
        discountedPrice: json["discounted_price"],
        price: json["price"],
        convertedPrice: double.parse(json["converted_price"]),
        convertedCurrencyCode: json["converted_currency_code"],
        quantity: json["quantity"],
        totalPrice: json["total_price"],
        totalConvertedPrice: double.parse(json["total_converted_price"]),
        picture: json["picture"],
      );

  Map<String, dynamic> toJson() => {
        "cart_id": cartId,
        "product_id": productId,
        "product_name": productName,
        "discount": discount,
        "discounted_price": discountedPrice,
        "price": price,
        "converted_price": convertedPrice,
        "converted_currency_code": convertedCurrencyCode,
        "quantity": quantity,
        "total_price": totalPrice,
        "total_converted_price": totalConvertedPrice,
        "picture": picture,
      };
}

class Totals {
  final int totalPrice;
  final int totalItems;

  Totals({
    required this.totalPrice,
    required this.totalItems,
  });

  factory Totals.fromJson(Map<String, dynamic> json) => Totals(
        totalPrice: json["total_price"],
        totalItems: json["total_items"],
      );

  Map<String, dynamic> toJson() => {
        "total_price": totalPrice,
        "total_items": totalItems,
      };
}
