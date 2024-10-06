// To parse this JSON data, do
//
//     final coporates = coporatesFromJson(jsonString);

import 'dart:convert';

Coporates coporatesFromJson(String str) => Coporates.fromJson(json.decode(str));

String coporatesToJson(Coporates data) => json.encode(data.toJson());

class Coporates {
  Coporates({
    required this.data,
  });

  final List<CoGroup> data;

  factory Coporates.fromJson(Map<String, dynamic> json) => Coporates(
        data: List<CoGroup>.from(json["data"].map((x) => CoGroup.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class CoGroup {
  CoGroup({
    required this.id,
    required this.groupName,
    required this.region,
    required this.country,
    required this.city,
    required this.district,
    required this.belongsToGrp,
    required this.status,
    required this.members,
    required this.farmersCount,
    required this.leaders,
    required this.message,
  });

  final String? id;
  final String? groupName;
  final String? region;
  final String? country;
  final String? city;
  final String? district;
  final String? belongsToGrp;
  final String? status;
  final List<Member>? members;
  final int? farmersCount;
  final List<Leader>? leaders;
  final String? message;

  factory CoGroup.fromJson(Map<String, dynamic> json) => CoGroup(
        id: json["id"],
        groupName: json["group_name"],
        region: json["region"],
        country: json["country"],
        city: json["city"],
        district: json["district"],
        belongsToGrp: json["belongs_to_grp"],
        status: json["status"],
        members:
            List<Member>.from(json["members"].map((x) => Member.fromJson(x))),
        farmersCount: json["farmers_count"],
        leaders:
            List<Leader>.from(json["leaders"].map((x) => Leader.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "group_name": groupName,
        "region": region,
        "country": country,
        "city": city,
        "district": district,
        "belongs_to_grp": belongsToGrp,
        "status": status,
        "members": List<dynamic>.from(members!.map((x) => x.toJson())),
        "farmers_count": farmersCount,
        "leaders": List<dynamic>.from(leaders!.map((x) => x.toJson())),
      };
}

class Leader {
  Leader({
    required this.id,
    required this.farmerId,
    required this.groupId,
    required this.status,
    required this.farmer,
    required this.message,
  });

  final int? id;
  final int? farmerId;
  final int? groupId;
  final String? status;
  final Farmer? farmer;
  final String? message;

  factory Leader.fromJson(Map<String, dynamic> json) => Leader(
        id: json["id"],
        farmerId: json["farmer_id"],
        groupId: json["group_id"],
        status: json["status"],
        farmer: json["farmer"] == null ? null : Farmer.fromJson(json["farmer"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "farmer_id": farmerId,
        "group_id": groupId,
        "status": status,
        "farmer": farmer!.toJson(),
        "message": message,
      };
}

class Member {
  Member({
    required this.id,
    required this.farmerId,
    required this.groupId,
    required this.status,
    required this.farmer,
    required this.message,
  });

  final int? id;
  final int? farmerId;
  final int? groupId;
  final String? status;
  final Farmer? farmer;
  final String? message;

  factory Member.fromJson(Map<String, dynamic> json) => Member(
      id: json["id"],
      farmerId: json["farmer_id"],
      groupId: json["group_id"],
      status: json["status"],
      farmer: Farmer.fromJson(json["farmer"]),
      message: json["message"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "farmer_id": farmerId,
        "group_id": groupId,
        "status": status,
        "farmer": farmer!.toJson(),
        "message": message,
      };
}

class Farmer {
  Farmer({
    required this.id,
    required this.firstName,
    required this.middleName,
    required this.surname,
    required this.sex,
    required this.farmerStatus,
    required this.country,
    required this.city,
    required this.region,
    required this.phoneNumber,
    required this.district,
    required this.community,
    required this.farmLocation,
    required this.services,
    required this.dob,
    required this.isPhysicallyChallenged,
    required this.crops,
    required this.landSize,
    required this.profilePicture,
    required this.partnerId,
    required this.groupId,
    required this.userId,
    required this.status,
    // required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final String firstName;
  final String middleName;
  final String surname;
  final String? sex;
  final String? farmerStatus;
  final String? country;
  final String? city;
  final String? region;
  final String phoneNumber;
  final String? district;
  final String? community;
  final String farmLocation;
  final String? services;
  final String dob;
  final String isPhysicallyChallenged;
  final String? crops;
  final String? landSize;
  final String? profilePicture;
  final String? partnerId;
  final String? groupId;
  final int userId;
  final String? status;
  // final DateTime? createdAt;
  final DateTime updatedAt;

  factory Farmer.fromJson(Map<String, dynamic> json) => Farmer(
        id: json["id"],
        firstName: json["first_name"],
        middleName: json["middle_name"] ?? 'null',
        surname: json["surname"],
        sex: json["sex"],
        farmerStatus: json["farmer_status"],
        country: json["country"],
        city: json["city"],
        region: json["region"],
        phoneNumber: json["phone_number"],
        district: json["district"],
        community: json["community"] ?? 'null',
        farmLocation: json["farm_location"] ?? 'null',
        services: json["services"],
        dob: json["dob"] ?? 'null',
        isPhysicallyChallenged: json["is_physically_challenged"] ?? 'null',
        crops: json["crops"] ?? 'null',
        landSize: json["land_size"] ?? 'null',
        profilePicture: json["profile_picture"] ?? 'null',
        partnerId: json["partner_id"] ?? 'null',
        groupId: json["group_id"] ?? 'null',
        userId: json["user_id"],
        status: json["status"] ?? 'null',
        // createdAt:
        //     json["status"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "middle_name": middleName,
        "surname": surname,
        "sex": sex,
        "farmer_status": farmerStatus,
        "country": country,
        "city": city,
        "region": region,
        "phone_number": phoneNumber,
        "district": district,
        "community": community,
        "farm_location": farmLocation,
        "services": services,
        "dob": dob,
        "is_physically_challenged": isPhysicallyChallenged,
        "crops": crops,
        "land_size": landSize,
        "profile_picture": profilePicture,
        "partner_id": partnerId,
        "group_id": groupId,
        "user_id": userId,
        "status": status,
        // "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
