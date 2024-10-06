// To parse this JSON data, do
//
//     final unitofMearsure = unitofMearsureFromJson(jsonString);

import 'dart:convert';

List<UnitofMearsure> unitofMearsureFromJson(String str) =>
    List<UnitofMearsure>.from(
        json.decode(str).map((x) => UnitofMearsure.fromJson(x)));

String unitofMearsureToJson(List<UnitofMearsure> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UnitofMearsure {
  UnitofMearsure({
    required this.id,
    required this.unitName,
    required this.symbol,
    required this.slug,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final String unitName;
  final String symbol;
  final String slug;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory UnitofMearsure.fromJson(Map<String, dynamic> json) => UnitofMearsure(
        id: json["id"],
        unitName: json["unit_name"],
        symbol: json["symbol"],
        slug: json["slug"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "unit_name": unitName,
        "symbol": symbol,
        "slug": slug,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };

  static List<UnitofMearsure> fromJsonList(List list) {
    return list.map((item) => UnitofMearsure.fromJson(item)).toList();
  }

  ///this method will prevent the override of toString
  String userAsString() {
    return '#$id $unitName';
  }

  ///this method will prevent the override of toString
  // bool userFilterByCreationDate(String filter) {
  //   return this?.createdAt?.toString()?.contains(filter);
  // }

  ///custom comparing function to check if two users are equal
  bool isEqual(UnitofMearsure model) {
    return id == model.id;
  }

  @override
  String toString() => '$unitName ($symbol)';
}
