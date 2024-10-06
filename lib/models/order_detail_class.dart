// To parse this JSON data, do
//
//     final orderDetailModel = orderDetailModelFromJson(jsonString);

import 'dart:convert';

OrderDetailModel orderDetailModelFromJson(String str) =>
    OrderDetailModel.fromJson(json.decode(str));

String orderDetailModelToJson(OrderDetailModel data) =>
    json.encode(data.toJson());

class OrderDetailModel {
  final Data data;

  OrderDetailModel({
    required this.data,
  });

  factory OrderDetailModel.fromJson(Map<String, dynamic> json) =>
      OrderDetailModel(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Data {
  final int orderId;
  final List<OrderItem> orderItems;
  final ShippingAddress shippingAddress;
  final dynamic deliveryMode;
  final OrderSummary orderSummary;

  Data({
    required this.orderId,
    required this.orderItems,
    required this.shippingAddress,
    required this.deliveryMode,
    required this.orderSummary,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        orderId: json["order_id"],
        orderItems: List<OrderItem>.from(
            json["order_items"].map((x) => OrderItem.fromJson(x))),
        shippingAddress: ShippingAddress.fromJson(json["shipping_address"]),
        deliveryMode: json["delivery_mode"],
        orderSummary: OrderSummary.fromJson(json["order_summary"]),
      );

  Map<String, dynamic> toJson() => {
        "order_id": orderId,
        "order_items": List<dynamic>.from(orderItems.map((x) => x.toJson())),
        "shipping_address": shippingAddress.toJson(),
        "delivery_mode": deliveryMode,
        "order_summary": orderSummary.toJson(),
      };
}

class OrderItem {
  final int productId;
  final double price;
  final double convertedPrice;
  final String quantity;
  final String convertedCurrencyCode;
  final String title;
  final String url;
  final double shippingFee;
  final double itemTotal;

  OrderItem({
    required this.productId,
    required this.price,
    required this.convertedPrice,
    required this.quantity,
    required this.convertedCurrencyCode,
    required this.title,
    required this.url,
    required this.shippingFee,
    required this.itemTotal,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
        productId: json["product_id"],
        price: double.parse(json["price"]),
        convertedPrice: double.parse(json["converted_price"]),
        quantity: json["quantity"],
        convertedCurrencyCode: json["converted_currency_code"],
        title: json["title"],
        url: json["url"],
        shippingFee: double.parse(json["shipping_fee"]),
        itemTotal: double.parse(json["item_total"]),
      );

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "price": price,
        "converted_price": convertedPrice,
        "quantity": quantity,
        "converted_currency_code": convertedCurrencyCode,
        "title": title,
        "url": url,
        "shipping_fee": shippingFee,
        "item_total": itemTotal,
      };
}

class OrderSummary {
  final double overallTotal;
  final double totalShippingFee;
  final String orderCode;
  final DateTime orderDate;
  final double totalConverted;
  final String convertedCurrencyCode;
  final String trxRef;
  final String status;

  OrderSummary({
    required this.overallTotal,
    required this.totalShippingFee,
    required this.orderCode,
    required this.orderDate,
    required this.totalConverted,
    required this.convertedCurrencyCode,
    required this.trxRef,
    required this.status,
  });

  factory OrderSummary.fromJson(Map<String, dynamic> json) => OrderSummary(
        overallTotal: double.parse(json["overall_total"]),
        totalShippingFee: double.parse(json["total_shipping_fee"]),
        orderCode: json["order_code"],
        orderDate: DateTime.parse(json["order_date"]),
        totalConverted: double.parse(json["total_converted"]),
        convertedCurrencyCode: json["converted_currency_code"],
        trxRef: json["trx_ref"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "overall_total": overallTotal,
        "total_shipping_fee": totalShippingFee,
        "order_code": orderCode,
        "order_date": orderDate.toIso8601String(),
        "total_converted": totalConverted,
        "converted_currency_code": convertedCurrencyCode,
        "trx_ref": trxRef,
        "status": status,
      };
}

class ShippingAddress {
  final String address;
  final String city;
  final String region;
  final String country;

  ShippingAddress({
    required this.address,
    required this.city,
    required this.region,
    required this.country,
  });

  factory ShippingAddress.fromJson(Map<String, dynamic> json) =>
      ShippingAddress(
        address: json["address"],
        city: json["city"],
        region: json["region"],
        country: json["country"],
      );

  Map<String, dynamic> toJson() => {
        "address": address,
        "city": city,
        "region": region,
        "country": country,
      };
}
