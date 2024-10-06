// To parse this JSON data, do
//
//     final orderModel = orderModelFromJson(jsonString);

import 'dart:convert';

OrderModel orderModelFromJson(String str) =>
    OrderModel.fromJson(json.decode(str));

String orderModelToJson(OrderModel data) => json.encode(data.toJson());

class OrderModel {
  final List<Order>? data;
  final String? message;

  OrderModel({
    this.data,
    this.message,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        data: List<Order>.from(json["data"].map((x) => Order.fromJson(x))),
        message: json['message'],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Order {
  final int id;
  final String orderCode;
  final String amount;
  final double convertedPrice;
  final String convertedCurrency;
  final String? deliveryMode;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int orderItemsCount;
  final int userId;
  final int shippingAddressId;
  final String? shippingFee;
  final String? totalFee;

  Order({
    required this.id,
    required this.orderCode,
    required this.amount,
    required this.convertedPrice,
    required this.convertedCurrency,
    this.deliveryMode,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.orderItemsCount,
    required this.userId,
    required this.shippingAddressId,
    this.shippingFee,
    this.totalFee,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        orderCode: json["order_code"],
        amount: json["amount"],
        convertedPrice: double.parse(json["converted_price"]),
        convertedCurrency: json["converted_currency"],
        deliveryMode: json["delivery_mode"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        orderItemsCount: json["order_items_count"],
        userId: json["user_id"],
        shippingAddressId: json["shipping_address_id"],
        shippingFee: json["shipping_fee"],
        totalFee: json["total_fee"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_code": orderCode,
        "amount": amount,
        "converted_price": convertedPrice,
        "converted_currency": convertedCurrency,
        "delivery_mode": deliveryMode,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "order_items_count": orderItemsCount,
        "user_id": userId,
        "shipping_address_id": shippingAddressId,
        "shipping_fee": shippingFee,
        "total_fee": totalFee,
      };
}
