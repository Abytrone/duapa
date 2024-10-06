import 'dart:convert';

import 'package:duapa/services/server.dart';
import 'package:duapa/views/account/orders/order_detail.dart';
import 'package:duapa/views/account/orders/payment.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/user_controller.dart';
import '../models/flutterwave_payment_verify.dart';
import '../views/widgets/loading_widget.dart';
import 'constants.dart';

class PaymentServices {
  final UserController userController = Get.find();
  // final PaymentController paymentController = Get.find();

  Future<bool> makePayment({
    required String orderId,
    required String txRef,
    required String amount,
    required String currencyCode,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('https://api.flutterwave.com/v3/payments'),
        body: jsonEncode({
          'tx_ref': txRef,
          'amount': amount,
          'currency': currencyCode,
          'redirect_url': 'https://con.duapa.online',
          'customer': {
            'email': userController.user.value.value!.user.email ??
                'duapa@ashantiproduce.com',
            'name': userController.user.value.value!.user.companyName ??
                '${userController.user.value.value!.user.firstName} ${userController.user.value.value!.user.surname}',
            'phonenumber': userController.user.value.value!.user.phoneNumber,
          },
          'customizations': {
            'title': 'Duapa Standard Payment',
          },
        }),
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              'Bearer FLWSECK-81e0449484a06ae48a7c8cb99bb441f5-18926562f73vt-X',
        },
      );
      // {
      //   "status": "success",
      //   "message": "Hosted Link",
      //   "data": {
      //     "link": "https://checkout.flutterwave.com/v3/hosted/pay/flwlnk-01hynrt7cd1fpm6gtef6khn93g"
      //   }
      // }
      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        if (result['status'] == 'success') {
          final res = await Get.to<bool>(
              () => PaymentScreen(paymentUrl: result['data']['link']));
          if (res!) {
            AbySnackBar.successSnackbar(text: 'Payment successful!');
            return true;
          } else {
            AbySnackBar.warningSnackbar(
                text: 'Payment failed, please try again!');
            return false;
          }
        } else {
          AbySnackBar.errorSnackbar(
              text: 'Payment unsuccessful!, please try again!');
          return false;
        }
      } else {
        AbySnackBar.errorSnackbar(text: 'Request failed, please try again!');
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<Tuple?> verifyPayment({required String txRef}) async {
    try {
      showDialog(
        context: Get.context!,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const LoadingDialog();
        },
      );
      final response = await http.get(
        // trx-9298965883501996
        Uri.parse(
            'https://api.flutterwave.com/v3/transactions/verify_by_reference?tx_ref=$txRef'),
        // body: jsonEncode({'tx_ref': 'duapa_tax_ref'}),
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              'Bearer FLWSECK-81e0449484a06ae48a7c8cb99bb441f5-18926562f73vt-X',
        },
      );

      if (response.statusCode == 200) {
        Navigator.of(Get.overlayContext!).pop();
        final result = flutterwavePaymentVerifyModelFromJson(response.body);
        return Tuple(
          data: result.data,
          status: result.status,
          message: result.message,
        );
      } else if (response.statusCode == 400) {
        // payment isn't made, but request is successful
        Navigator.of(Get.overlayContext!).pop();
        final result = flutterwavePaymentVerifyModelFromJson(response.body);

        return Tuple(
          data: result.data,
          status: result.status,
          message: result.message,
        );
      } else {
        Navigator.of(Get.overlayContext!).pop();
        AbySnackBar.errorSnackbar(text: 'Payment verification failed!');
        return null;
      }
    } catch (e) {
      AbySnackBar.errorSnackbar(text: 'Error occured, please try again.');
      return null;
    }
  }

  Future<bool> updateDuapaPayment({
    required String orderId,
    required String total,
    required String transactionId,
    required String txRef,
    required String flwRef,
    required String status,
  }) async {
    try {
      final SharedPreferences localStorage =
          await SharedPreferences.getInstance();
      var token = localStorage.getString('token');
      var response = await http.post(
        Uri.parse('$protocol$baseUrl/api/v1/order/payment/add'),
        body: jsonEncode({
          "order_id": orderId,
          "payment_amount": total,
          "transaction_id": transactionId,
          "tx_ref": txRef,
          "flw_ref": flwRef,
          "payment_status": status,
          "payment_mode": '2',
        }),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );

      if (response.statusCode == 201) {
        AbySnackBar.successSnackbar(text: 'Payment verification successful!');
        Get.to(() => OrderDetailScreen(
              orderid: int.parse(orderId),
              paymentStatus: status,
            ));
        return true;
      } else {
        AbySnackBar.errorSnackbar(
            text: 'Payment verification failed, please try again.');
        return false;
      }
    } catch (e) {
      AbySnackBar.errorSnackbar(text: 'Error occured, please try again.');
      return false;
    }
  }

  Future<String?> getCountry() async {
    try {
      final response = await http.get(
        Uri.parse("http://ip-api.com/json"),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      // print(response.body);
      if (response.statusCode == 200) {
        final location = jsonDecode(response.body);
        if (location['status'] == 'success') {
          return location["country"];
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
