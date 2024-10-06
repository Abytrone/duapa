// To parse this JSON data, do
//
//     final signupErrors = signupErrorsFromJson(jsonString);

import 'dart:convert';

SignupErrors signupErrorsFromJson(String str) =>
    SignupErrors.fromJson(json.decode(str));

String signupErrorsToJson(SignupErrors data) => json.encode(data.toJson());

class SignupErrors {
  SignupErrors({
    required this.message,
    required this.errors,
  });

  final String message;
  final Errors errors;

  factory SignupErrors.fromJson(Map<String, dynamic> json) => SignupErrors(
        message: json["message"],
        errors: Errors.fromJson(json["errors"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "errors": errors.toJson(),
      };
}

class Errors {
  Errors({
    this.email,
    this.username,
    this.phoneNumber,
  });

  final List<String>? email;
  final List<dynamic>? username;
  final List<String>? phoneNumber;

  factory Errors.fromJson(Map<String, dynamic> json) => Errors(
        email: List<String>.from(json["email"].map((x) => x)),
        username: List<dynamic>.from(json["username"].map((x) => x)),
        phoneNumber: List<String>.from(json["phone_number"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "email": List<dynamic>.from(email!.map((x) => x)),
        "username": List<dynamic>.from(username!.map((x) => x)),
        "phone_number": List<dynamic>.from(phoneNumber!.map((x) => x)),
      };
}
