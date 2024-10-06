// To parse this JSON data, do
//
//     final category = categoryFromJson(jsonString);

import 'dart:convert';

List<Category> categoryFromJson(String str) =>
    List<Category>.from(json.decode(str).map((x) => Category.fromJson(x)));

String categoryToJson(List<Category> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Category {
  Category({
    required this.id,
    required this.categoryName,
    required this.picture,
    required this.categoryStatus,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String categoryName;
  String? picture;
  String categoryStatus;
  DateTime createdAt;
  DateTime updatedAt;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        categoryName: json["category_name"],
        picture: json["picture"],
        categoryStatus: json["category_status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category_name": categoryName,
        "picture": picture,
        "category_status": categoryStatus,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };

  static List<Category> fromJsonList(List list) {
    return list.map((item) => Category.fromJson(item)).toList();
  }

  ///this method will prevent the override of toString
  String userAsString() {
    return '#$id $categoryName';
  }

  ///this method will prevent the override of toString
  // bool userFilterByCreationDate(String filter) {
  //   return this?.createdAt?.toString()?.contains(filter);
  // }

  ///custom comparing function to check if two users are equal
  bool isEqual(Category model) {
    return id == model.id;
  }

  @override
  String toString() => categoryName;
}



// List<Category> category = [
  // const Category(
    // text: "Machinery",
    // image: "assets/img/transportation.png",
  // ),
  // const Category(
    // text: "Food Stuff",
    // image: "assets/img/vegetable.png",
  // ),
  // const Category(
    // text: "Fertilizers",
    // image: "assets/img/fertilizer.png",
  // ),
  // const Category(
    // text: "Fungicides",
    // image: "assets/img/insecticide.png",
  // ),
  // const Category(
    // text: "Seedlings",
    // image: "assets/img/tree.png",
  // ),
  // const Category(
    // text: "Pesticides",
    // image: "assets/img/pesticide.png",
  // ),
  // const Category(
    // text: "Feeds",
    // image: "assets/img/poultry.png",
  // ),
  // const Category(
    // text: "Weedicides",
    // image: "assets/img/pesticide (2).png",
  // ),
// ];
