// // {
// //     "message": "no products available"
// // }
// // To parse this JSON data, do
// //
// //     final farmerProducts = farmerProductsFromJson(jsonString);

// import 'dart:convert';

// FarmerProducts farmerProductsFromJson(String str) =>
//     FarmerProducts.fromJson(json.decode(str));

// String farmerProductsToJson(FarmerProducts data) => json.encode(data.toJson());

// class FarmerProducts {
//   FarmerProducts({
//     required this.data,
//     required this.message,
//   });

//   final List<FarmerProduct>? data;
//   final String? message;

//   factory FarmerProducts.fromJson(Map<String, dynamic> json) => FarmerProducts(
//         data: json["data"] == null
//             ? null
//             : List<FarmerProduct>.from(
//                 json["data"].map((x) => FarmerProduct.fromJson(x))),
//         message: json["message"],
//       );

//   Map<String, dynamic> toJson() => {
//         "data": List<dynamic>.from(data!.map((x) => x.toJson())),
//       };
// }

// class FarmerProduct {
//   FarmerProduct({
//     required this.id,
//     required this.name,
//     required this.code,
//     required this.price,
//     required this.discount,
//     required this.rating,
//     required this.quantity,
//     required this.deliveryMode,
//     required this.picture,
//     // required this.postedBy,
//     required this.status,
//     required this.keyHighlights,
//     // required this.drivers,
//     required this.pictureGallery,
//   });

//   final String id;
//   final String name;
//   final String code;
//   final String price;
//   final String discount;
//   final String rating;
//   final String quantity;
//   final String deliveryMode;
//   final String picture;
//   // final PostedBy postedBy;
//   final String status;
//   final KeyHighlights keyHighlights;
//   // final Drivers drivers;
//   final List<PictureGallery> pictureGallery;

//   factory FarmerProduct.fromJson(Map<String, dynamic> json) => FarmerProduct(
//         id: json["id"],
//         name: json["name"],
//         code: json["code"],
//         price: json["price"],
//         discount: json["discount"],
//         rating: json["rating"],
//         quantity: json["quantity"],
//         deliveryMode: json["delivery_mode"],
//         picture: json["picture"],
//         // postedBy: PostedBy.fromJson(json["posted_by"]),
//         status: json["status"],
//         keyHighlights: KeyHighlights.fromJson(json["key_highlights"]),
//         // drivers: Drivers.fromJson(json["drivers"]),
//         pictureGallery: List<PictureGallery>.from(
//             json["picture_gallery"].map((x) => PictureGallery.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "code": code,
//         "price": price,
//         "discount": discount,
//         "rating": rating,
//         "quantity": quantity,
//         "delivery_mode": deliveryMode,
//         "picture": picture,
//         // "posted_by": postedBy.toJson(),
//         "status": status,
//         "key_highlights": keyHighlights.toJson(),
//         // "drivers": drivers.toJson(),
//         "picture_gallery":
//             List<dynamic>.from(pictureGallery.map((x) => x.toJson())),
//       };
// }

// // class Drivers {
// //   Drivers({
// //     required this.withinCity,
// //     required this.withinRegion,
// //     required this.withinCountry,
// //   });

// //   final List<Within> withinCity;
// //   final List<Within> withinRegion;
// //   final List<WithinCountry> withinCountry;

// //   factory Drivers.fromJson(Map<String, dynamic> json) => Drivers(
// //         withinCity: List<Within>.from(
// //             json["within_city"].map((x) => Within.fromJson(x))),
// //         withinRegion: List<Within>.from(
// //             json["within_region"].map((x) => Within.fromJson(x))),
// //         withinCountry: List<WithinCountry>.from(
// //             json["within_country"].map((x) => WithinCountry.fromJson(x))),
// //       );

// //   Map<String, dynamic> toJson() => {
// //         "within_city": List<dynamic>.from(withinCity.map((x) => x.toJson())),
// //         "within_region":
// //             List<dynamic>.from(withinRegion.map((x) => x.toJson())),
// //         "within_country":
// //             List<dynamic>.from(withinCountry.map((x) => x.toJson())),
// //       };
// // }

// // class Within {
// //   Within({
// //     required this.message,
// //   });

// //   final String message;

// //   factory Within.fromJson(Map<String, dynamic> json) => Within(
// //         message: json["message"],
// //       );

// //   Map<String, dynamic> toJson() => {
// //         "message": message,
// //       };
// // }

// // class WithinCountry {
// //   WithinCountry({
// //     required this.id,
// //     required this.firstName,
// //     required this.middleName,
// //     required this.surname,
// //     required this.phoneNumber,
// //     required this.sex,
// //     required this.country,
// //     required this.region,
// //     required this.city,
// //     required this.dob,
// //     required this.driverLicense,
// //     required this.roadWorthy,
// //     required this.insurance,
// //     required this.profilePicture,
// //     required this.status,
// //     required this.userId,
// //     required this.createdAt,
// //     required this.updatedAt,
// //   });

// //   final int id;
// //   final String firstName;
// //   final dynamic middleName;
// //   final String surname;
// //   final String phoneNumber;
// //   final String sex;
// //   final String country;
// //   final String region;
// //   final String city;
// //   final dynamic dob;
// //   final String driverLicense;
// //   final String roadWorthy;
// //   final String insurance;
// //   final String profilePicture;
// //   final String status;
// //   final int userId;
// //   final DateTime createdAt;
// //   final DateTime updatedAt;

// //   factory WithinCountry.fromJson(Map<String, dynamic> json) => WithinCountry(
// //         id: json["id"],
// //         firstName: json["first_name"],
// //         middleName: json["middle_name"],
// //         surname: json["surname"],
// //         phoneNumber: json["phone_number"],
// //         sex: json["sex"],
// //         country: json["country"],
// //         region: json["region"],
// //         city: json["city"],
// //         dob: json["dob"],
// //         driverLicense: json["driver_license"],
// //         roadWorthy: json["road_worthy"],
// //         insurance: json["insurance"],
// //         profilePicture: json["profile_picture"],
// //         status: json["status"],
// //         userId: json["user_id"],
// //         createdAt: DateTime.parse(json["created_at"]),
// //         updatedAt: DateTime.parse(json["updated_at"]),
// //       );

// //   Map<String, dynamic> toJson() => {
// //         "id": id,
// //         "first_name": firstName,
// //         "middle_name": middleName,
// //         "surname": surname,
// //         "phone_number": phoneNumber,
// //         "sex": sex,
// //         "country": country,
// //         "region": region,
// //         "city": city,
// //         "dob": dob,
// //         "driver_license": driverLicense,
// //         "road_worthy": roadWorthy,
// //         "insurance": insurance,
// //         "profile_picture": profilePicture,
// //         "status": status,
// //         "user_id": userId,
// //         "created_at": createdAt.toIso8601String(),
// //         "updated_at": updatedAt.toIso8601String(),
// //       };
// // }

// class KeyHighlights {
//   KeyHighlights({
//     required this.sowingSeason,
//     required this.sowingMethod,
//     required this.sowingSpacing,
//     required this.specialRemark,
//     required this.firstHarvest,
//     required this.description,
//   });

//   final String sowingSeason;
//   final String sowingMethod;
//   final String sowingSpacing;
//   final String specialRemark;
//   final String firstHarvest;
//   final String description;

//   factory KeyHighlights.fromJson(Map<String, dynamic> json) => KeyHighlights(
//         sowingSeason: json["sowing_season"],
//         sowingMethod: json["sowing_method"],
//         sowingSpacing: json["sowing_spacing"],
//         specialRemark: json["special_remark"],
//         firstHarvest: json["first_harvest"],
//         description: json["description"],
//       );

//   Map<String, dynamic> toJson() => {
//         "sowing_season": sowingSeason,
//         "sowing_method": sowingMethod,
//         "sowing_spacing": sowingSpacing,
//         "special_remark": specialRemark,
//         "first_harvest": firstHarvest,
//         "description": description,
//       };
// }

// class PictureGallery {
//   PictureGallery({
//     required this.id,
//     required this.productId,
//     required this.url,
//     required this.createdAt,
//     required this.updatedAt,
//   });

//   final int id;
//   final int productId;
//   final String url;
//   final DateTime createdAt;
//   final DateTime updatedAt;

//   factory PictureGallery.fromJson(Map<String, dynamic> json) => PictureGallery(
//         id: json["id"],
//         productId: json["product_id"],
//         url: json["url"],
//         createdAt: DateTime.parse(json["created_at"]),
//         updatedAt: DateTime.parse(json["updated_at"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "product_id": productId,
//         "url": url,
//         "created_at": createdAt.toIso8601String(),
//         "updated_at": updatedAt.toIso8601String(),
//       };
// }

// // class PostedBy {
// //   PostedBy({
// //     @required this.id,
// //     @required this.firstName,
// //     @required this.middleName,
// //     @required this.surname,
// //     @required this.sex,
// //     @required this.farmerStatus,
// //     @required this.country,
// //     @required this.city,
// //     @required this.region,
// //     @required this.phoneNumber,
// //     @required this.district,
// //     @required this.community,
// //     @required this.farmLocation,
// //     @required this.services,
// //     @required this.dob,
// //     @required this.isPhysicallyChallenged,
// //     @required this.crops,
// //     @required this.landSize,
// //     @required this.profilePicture,
// //     @required this.partnerId,
// //     @required this.groupId,
// //     @required this.userId,
// //     @required this.status,
// //     @required this.createdAt,
// //     @required this.updatedAt,
// //   });

// //   final int id;
// //   final String firstName;
// //   final dynamic middleName;
// //   final String surname;
// //   final String sex;
// //   final dynamic farmerStatus;
// //   final String country;
// //   final String city;
// //   final String region;
// //   final String phoneNumber;
// //   final dynamic district;
// //   final dynamic community;
// //   final dynamic farmLocation;
// //   final String services;
// //   final dynamic dob;
// //   final dynamic isPhysicallyChallenged;
// //   final dynamic crops;
// //   final dynamic landSize;
// //   final String profilePicture;
// //   final dynamic partnerId;
// //   final dynamic groupId;
// //   final int userId;
// //   final String status;
// //   final DateTime createdAt;
// //   final DateTime updatedAt;

// //   factory PostedBy.fromJson(Map<String, dynamic> json) => PostedBy(
// //         id: json["id"],
// //         firstName: json["first_name"],
// //         middleName: json["middle_name"],
// //         surname: json["surname"],
// //         sex: json["sex"],
// //         farmerStatus: json["farmer_status"],
// //         country: json["country"],
// //         city: json["city"],
// //         region: json["region"],
// //         phoneNumber: json["phone_number"],
// //         district: json["district"],
// //         community: json["community"],
// //         farmLocation: json["farm_location"],
// //         services: json["services"],
// //         dob: json["dob"],
// //         isPhysicallyChallenged: json["is_physically_challenged"],
// //         crops: json["crops"],
// //         landSize: json["land_size"],
// //         profilePicture: json["profile_picture"],
// //         partnerId: json["partner_id"],
// //         groupId: json["group_id"],
// //         userId: json["user_id"],
// //         status: json["status"],
// //         createdAt: DateTime.parse(json["created_at"]),
// //         updatedAt: DateTime.parse(json["updated_at"]),
// //       );

// //   Map<String, dynamic> toJson() => {
// //         "id": id,
// //         "first_name": firstName,
// //         "middle_name": middleName,
// //         "surname": surname,
// //         "sex": sex,
// //         "farmer_status": farmerStatus,
// //         "country": country,
// //         "city": city,
// //         "region": region,
// //         "phone_number": phoneNumber,
// //         "district": district,
// //         "community": community,
// //         "farm_location": farmLocation,
// //         "services": services,
// //         "dob": dob,
// //         "is_physically_challenged": isPhysicallyChallenged,
// //         "crops": crops,
// //         "land_size": landSize,
// //         "profile_picture": profilePicture,
// //         "partner_id": partnerId,
// //         "group_id": groupId,
// //         "user_id": userId,
// //         "status": status,
// //         "created_at": createdAt.toIso8601String(),
// //         "updated_at": updatedAt.toIso8601String(),
// //       };
// // }
