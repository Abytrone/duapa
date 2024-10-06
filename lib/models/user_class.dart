// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  final UserClass user;
  final String token;
  final String preferredCurrency;

  User({
    required this.user,
    required this.token,
    required this.preferredCurrency,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        user: UserClass.fromJson(json["data"]),
        token: json["token"].toString(),
        preferredCurrency: json['preferred_currency'],
      );

  Map<String, dynamic> toJson() => {
        "data": user.toJson(),
        "token": token,
      };
}

UserClass userClassFromJson(String str) => UserClass.fromJson(json.decode(str));

class UserClass {
  UserClass({
    required this.id,
    required this.username,
    required this.phoneNumber,
    required this.email,
    required this.role,
    required this.firstName,
    required this.middleName,
    required this.surname,
    required this.name,
    required this.sex,
    required this.farmerStatus,
    required this.region,
    required this.district,
    required this.community,
    required this.farmLocation,
    required this.dob,
    required this.isPhysicallyChallenged,
    required this.crops,
    required this.landSize,
    required this.profilePicture,
    required this.partnerId,
    required this.groupId,
    required this.companyName,
    required this.country,
    required this.state,
    required this.city,
    required this.gpsAddress,
    required this.services,
    required this.status,
    this.totalAmountSold,
    this.totalAmountPending,
    required this.totalFarmers,
    // required this.createdAt,
    // required this.updatedAt,
    // required this.profilePhotoUrl,
  });

  String id;
  String? username;
  String? phoneNumber;
  String? email;
  String? role;
  String? firstName;
  String? middleName;
  String? surname;
  String? name;
  String? sex;
  String? farmerStatus;
  String? region;
  String? district;
  String? community;
  String? farmLocation;
  String? dob;
  String? isPhysicallyChallenged;
  String? crops;
  String? landSize;
  String? profilePicture;
  String? partnerId;
  String? groupId;
  String? companyName;
  String? country;
  String? state;
  String? city;
  String? gpsAddress;
  String? services;
  String? status;
  int? totalAmountSold;
  dynamic totalAmountPending;
  int? totalFarmers;

  // DateTime? createdAt;
  // DateTime? updatedAt;
  // String? profilePhotoUrl;

  factory UserClass.fromJson(Map<String, dynamic> json) => UserClass(
        id: json["id"],
        username: json["username"],
        phoneNumber: json["phone_number"],
        email: json["email"],
        role: json["role"],
        firstName: json["first_name"],
        middleName: json["middle_name"],
        surname: json["surname"],
        name: json["name"],
        sex: json["sex"],
        farmerStatus: json["farmer_status"],
        region: json["region"],
        district: json["district"],
        community: json["community"],
        farmLocation: json["farm_location"],
        dob: json["dob"],
        isPhysicallyChallenged: json["is_physically_challenged"],
        crops: json["crops"],
        landSize: json["land_size"],
        profilePicture: json["profile_picture"],
        partnerId: json["partner_id"],
        groupId: json["group_id"],
        companyName: json["company_name"],
        country: json["country"],
        state: json["region"],
        city: json["city"],
        gpsAddress: json["gps_address"],
        services: json["services"],
        status: json["status"],
        totalAmountSold: json["total_amount_sold"],
        totalAmountPending: json["total_amount_pending"],
        totalFarmers: json["total_farmers"],
        // createdAt: DateTime.parse(json["created_at"]),
        // updatedAt: DateTime.parse(json["updated_at"]),
        // profilePhotoUrl: json["profile_photo_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "phone_number": phoneNumber,
        "email": email,
        "usertype": role,
        "first_name": firstName,
        "middle_name": middleName,
        "surname": surname,
        "name": name,
        "sex": sex,
        "farmer_status": farmerStatus,
        "region": region,
        "district": district,
        "community": community,
        "farm_location": farmLocation,
        "dob": dob,
        "is_physically_challenged": isPhysicallyChallenged,
        "crops": crops,
        "land_size": landSize,
        "profile_picture": profilePicture,
        "partner_id": partnerId,
        "group_id": groupId,
        "company_name": companyName,
        "country": country,
        "state": state,
        "city": city,
        "gps_address": gpsAddress,
        "services": services,
        "total_amount_sold": totalAmountSold,
        "total_amount_pending": totalAmountPending,
        "status": status,
        // "created_at": createdAt!.toIso8601String(),
        // "updated_at": updatedAt!.toIso8601String(),
        // "profile_photo_url": profilePhotoUrl,
      };
}
