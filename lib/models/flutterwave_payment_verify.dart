// To parse this JSON data, do
//
//     final flutterwavePaymentVerifyModel = flutterwavePaymentVerifyModelFromJson(jsonString);

import 'dart:convert';

FlutterwavePaymentVerifyModel flutterwavePaymentVerifyModelFromJson(
        String str) =>
    FlutterwavePaymentVerifyModel.fromJson(json.decode(str));

String flutterwavePaymentVerifyModelToJson(
        FlutterwavePaymentVerifyModel data) =>
    json.encode(data.toJson());

class FlutterwavePaymentVerifyModel {
  final String status;
  final String message;
  final Data? data;

  FlutterwavePaymentVerifyModel({
    required this.status,
    required this.message,
    this.data,
  });

  factory FlutterwavePaymentVerifyModel.fromJson(Map<String, dynamic> json) =>
      FlutterwavePaymentVerifyModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data!.toJson(),
      };
}

class Data {
  final int id;
  final String txRef;
  final String flwRef;
  final String deviceFingerprint;
  final dynamic amount;
  final String currency;
  final dynamic chargedAmount;
  final double appFee;
  final int merchantFee;
  final String processorResponse;
  final String authModel;
  final String ip;
  final String narration;
  final String status;
  final String paymentType;
  final DateTime createdAt;
  final int accountId;
  final dynamic meta;
  final double amountSettled;
  final Customer customer;

  Data({
    required this.id,
    required this.txRef,
    required this.flwRef,
    required this.deviceFingerprint,
    required this.amount,
    required this.currency,
    required this.chargedAmount,
    required this.appFee,
    required this.merchantFee,
    required this.processorResponse,
    required this.authModel,
    required this.ip,
    required this.narration,
    required this.status,
    required this.paymentType,
    required this.createdAt,
    required this.accountId,
    this.meta,
    required this.amountSettled,
    required this.customer,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        txRef: json["tx_ref"],
        flwRef: json["flw_ref"],
        deviceFingerprint: json["device_fingerprint"],
        amount: json["amount"],
        currency: json["currency"],
        chargedAmount: json["charged_amount"],
        appFee: json["app_fee"]?.toDouble(),
        merchantFee: json["merchant_fee"],
        processorResponse: json["processor_response"],
        authModel: json["auth_model"],
        ip: json["ip"],
        narration: json["narration"],
        status: json["status"],
        paymentType: json["payment_type"],
        createdAt: DateTime.parse(json["created_at"]),
        accountId: json["account_id"],
        meta: json["meta"],
        amountSettled: json["amount_settled"]?.toDouble(),
        customer: Customer.fromJson(json["customer"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tx_ref": txRef,
        "flw_ref": flwRef,
        "device_fingerprint": deviceFingerprint,
        "amount": amount,
        "currency": currency,
        "charged_amount": chargedAmount,
        "app_fee": appFee,
        "merchant_fee": merchantFee,
        "processor_response": processorResponse,
        "auth_model": authModel,
        "ip": ip,
        "narration": narration,
        "status": status,
        "payment_type": paymentType,
        "created_at": createdAt.toIso8601String(),
        "account_id": accountId,
        "meta": meta,
        "amount_settled": amountSettled,
        "customer": customer.toJson(),
      };
}

class Customer {
  final int id;
  final String name;
  final String phoneNumber;
  final String email;
  final DateTime createdAt;

  Customer({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.email,
    required this.createdAt,
  });

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: json["id"],
        name: json["name"],
        phoneNumber: json["phone_number"],
        email: json["email"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phone_number": phoneNumber,
        "email": email,
        "created_at": createdAt.toIso8601String(),
      };
}

class Tuple {
  final Data? data;
  final String status;
  final String message;

  Tuple({
    this.data,
    required this.status,
    required this.message,
  });
}
