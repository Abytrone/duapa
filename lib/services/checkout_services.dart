import 'dart:convert';

import 'package:duapa/services/constants.dart';
import 'package:duapa/services/server.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../views/widgets/loading_widget.dart';

class CheckoutServices {
  Future<bool> addOrder({
    required String shippingAddress,
    required String deliveryMode,
    required List<Map<String, String>> products,
  }) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const LoadingDialog();
      },
    );
    try {
      final Map<String, dynamic> body = {
        "order_items": products,
        "shipping_address_id": shippingAddress,
        "delivery_mode": deliveryMode,
      };
      // print(jsonEncode(body));
      var response = await http.post(
        Uri.parse('$protocol$baseUrl/api/v1/order/create-order'),
        body: jsonEncode(body),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      // print(response.body);
      // print(response.statusCode);
      if (response.statusCode == 201) {
        Navigator.of(Get.overlayContext!).pop();
        AbySnackBar.successSnackbar(text: 'Order submitted successfully');
        return true;
      } else {
        Navigator.of(Get.overlayContext!).pop();
        AbySnackBar.errorSnackbar(text: 'Error submitting order');
        return false;
      }
    } catch (e) {
      Navigator.of(Get.overlayContext!).pop();
      AbySnackBar.errorSnackbar(text: 'Request failed');
      return false;
    }
  }

  // --------------------------------------------------------------
}
