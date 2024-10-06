import 'package:duapa/models/support_ticket_class.dart';
import 'package:duapa/services/constants.dart';
import 'package:duapa/services/server.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../views/account/support/support_tickets.dart';
import '../views/widgets/loading_widget.dart';

class SupportTicketServices {
  static Future<bool> sendTicket(
      {required String topic,
      required String message,
      required BuildContext context}) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    Get.dialog(
      const LoadingDialog(),
      barrierDismissible: false,
    );
    var response = await http.post(
      Uri.parse(
          'https://$baseUrl/api/v1/ticket/create?topic=$topic&concern=$message'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    // print(response.body);
    if (response.statusCode == 201) {
      Navigator.of(Get.overlayContext!).pop();
      Get.to(() => const SupportTicketsScreen());
      AbySnackBar.successSnackbar(text: 'Message sent successfully!');
      return true;
    } else {
      Navigator.of(Get.overlayContext!).pop();
      AbySnackBar.errorSnackbar(
          text: 'Request failed with status: ${response.statusCode}.');
      return false;
    }
  }

  Future<List<SupportTicket>?> getTickets() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    var response = await http.get(
      Uri.parse('https://$baseUrl/api/v1/ticket/list'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    if (response.statusCode == 200) {
      var ticket = supportTicketFromJson(response.body);
      return ticket;
    } else {
      return null;
    }
  }
}
