// To parse this JSON data, do
//
//     final transport = transportFromJson(jsonString);

import 'dart:convert';

Transport transportFromJson(String str) => Transport.fromJson(json.decode(str));

String transportToJson(Transport data) => json.encode(data.toJson());

class Transport {
  Transport({
    required this.data,
  });

  final List<Driver> data;

  factory Transport.fromJson(Map<String, dynamic> json) => Transport(
        data: List<Driver>.from(json["data"].map((x) => Driver.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Driver {
  Driver({
    required this.id,
    required this.firstName,
    required this.middleName,
    required this.username,
    required this.surname,
    required this.sex,
    required this.userId,
    required this.country,
    required this.region,
    required this.city,
    required this.driverLicense,
    required this.status,
    required this.roadWorthy,
    required this.insurance,
    required this.profilePicture,
    required this.dob,
    required this.phoneNumber,
    required this.bio,
  });

  final String id;
  final String firstName;
  final String middleName;
  final String username;
  final String surname;
  final String sex;
  final int userId;
  final String country;
  final String region;
  final String city;
  final String driverLicense;
  final String status;
  final String roadWorthy;
  final String insurance;
  final String profilePicture;
  final String dob;
  final String phoneNumber;
  final String? bio;

  factory Driver.fromJson(Map<String, dynamic> json) => Driver(
        id: json["id"],
        firstName: json["first_name"],
        middleName: json["middle_name"],
        username: json["username"],
        surname: json["surname"],
        sex: json["sex"],
        userId: json["user_id"],
        country: json["country"],
        region: json["region"],
        city: json["city"],
        driverLicense: json["driver_license"],
        status: json["status"],
        roadWorthy: json["road_worthy"],
        insurance: json["insurance"],
        profilePicture: json["profile_picture"],
        dob: json["dob"],
        phoneNumber: json["phone_number"],
        bio: json["bio"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "middle_name": middleName,
        "username": username,
        "surname": surname,
        "sex": sex,
        "user_id": userId,
        "country": country,
        "region": region,
        "city": city,
        "driver_license": driverLicense,
        "status": status,
        "road_worthy": roadWorthy,
        "insurance": insurance,
        "profile_picture": profilePicture,
        "dob": dob,
        "phone_number": phoneNumber,
        "bio": bio,
      };
}
