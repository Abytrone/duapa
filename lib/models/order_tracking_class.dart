// To parse this JSON data, do
//
//     final orderTracking = orderTrackingFromJson(jsonString);

import 'dart:convert';

OrderTracking orderTrackingFromJson(String str) =>
    OrderTracking.fromJson(json.decode(str));

String orderTrackingToJson(OrderTracking data) => json.encode(data.toJson());

class OrderTracking {
  final List<Datum> data;

  OrderTracking({
    required this.data,
  });

  factory OrderTracking.fromJson(Map<String, dynamic> json) => OrderTracking(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  final String svg;
  final String title;
  final String message;
  final int isFirst;
  final int isLast;

  Datum({
    required this.svg,
    required this.title,
    required this.message,
    required this.isFirst,
    required this.isLast,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        svg: json["svg"],
        title: json["title"],
        message: json["message"],
        isFirst: json["isFirst"],
        isLast: json["isLast"],
      );

  Map<String, dynamic> toJson() => {
        "svg": svg,
        "title": title,
        "message": message,
        "isFirst": isFirst,
        "isLast": isLast,
      };
}
