// To parse this JSON data, do
//
//     final supportTicket = supportTicketFromJson(jsonString);

import 'dart:convert';

List<SupportTicket> supportTicketFromJson(String str) =>
    List<SupportTicket>.from(
        json.decode(str).map((x) => SupportTicket.fromJson(x)));

String supportTicketToJson(List<SupportTicket> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SupportTicket {
  SupportTicket({
    required this.id,
    required this.userId,
    required this.topic,
    required this.concern,
    required this.response,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final int userId;
  final String topic;
  final String concern;
  final String? response;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory SupportTicket.fromJson(Map<String, dynamic> json) => SupportTicket(
        id: json["id"],
        userId: json["user_id"],
        topic: json["topic"],
        concern: json["concern"],
        response: json["response"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "topic": topic,
        "concern": concern,
        "response": response,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
