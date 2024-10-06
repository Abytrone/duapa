import 'dart:convert';

import 'package:duapa/services/server.dart';
import 'package:duapa/views/auth_views/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../views/auth_views/otp_screen.dart';
import '../views/widgets/loading_widget.dart';
import 'constants.dart';

class PasswordResetServices {
  Future<bool> otpSend(
      {required String email, String? phone, required String isoCode}) async {
    try {
      Get.dialog(
        const LoadingDialog(),
        barrierDismissible: false,
      );
      Uri phoneUrl = Uri.parse(
          'https://$baseUrl/api/v1/auth/user-otp-send?phone_number=$phone&country_code=$isoCode&reset_password=1');
      Uri emailUrl = Uri.parse(
          'https://$baseUrl/api/v1/auth/user-otp-send?email=$email&reset_password=1');
      final response = await http.post(
        phone != null ? phoneUrl : emailUrl,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );

      // print(response.body);
      var responseBody = jsonDecode(response.body);

      if (response.statusCode == 200) {
        Navigator.of(Get.overlayContext!).pop();
        if (responseBody['status'] == 'pending') {
          Get.to(() => OtpScreen(
                email: email,
                phoneNumber: phone,
                isResetPassword: true,
              ));
          return true;
        } else {
          AbySnackBar.warningSnackbar(text: responseBody['message']);
          return false;
        }
      } else {
        Navigator.of(Get.overlayContext!).pop();
        AbySnackBar.warningSnackbar(text: responseBody['errors']);
        return false;
      }
    } catch (e) {
      Navigator.of(Get.overlayContext!).pop();
      AbySnackBar.warningSnackbar(text: 'Error occured, please try again.');
      return false;
    }
  }

  //--------------------------SET-SECURITY-QUESTIONS------------------------
  // Future<bool> setNewPassword({
  //   required String phone,
  //   required String newPassword,
  //   required String confirmNewPassword,
  // }) async {
  //   Get.dialog(
  //     const LoadingDialog(),
  //     barrierDismissible: false,
  //   );
  //   try {
  //     Uri url =
  //         Uri.parse('https://$baseUrl/api/v1/auth/users/confirm-password');
  //     final response = await http.post(
  //       url,
  //       body: {
  //         'phone_number': phone,
  //         'password': newPassword,
  //         'confirm_password': confirmNewPassword,
  //       },
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'Accept': 'application/json',
  //       },
  //     );
  //     print('Set New Password');
  //     print(response.statusCode);
  //     print(response.body);

  //     if (response.statusCode == 200) {
  //       // var jsonResponse = jsonDecode(response.body);
  //       Navigator.pop(Get.overlayContext!);
  //       AbySnackBar.successSnackbar(text: 'Password reset successfully');
  //       return true;
  //     } else {
  //       Navigator.pop(Get.overlayContext!);
  //       AbySnackBar.warningSnackbar(
  //           text: 'Request failed with status: ${response.statusCode}.');
  //       return false;
  //     }
  //   } catch (e) {
  //     Navigator.pop(Get.overlayContext!);
  //     AbySnackBar.errorSnackbar(text: 'Request failed with status: $e.');
  //     return false;
  //   }
  // }

  //--------------------------REQUEST-PASSWORD-RESET------------------------
  Future<bool> requestPasswordReset({
    String? phone,
    String? email,
    required String otp,
    required String password,
    required String confirmPassword,
  }) async {
    Get.dialog(
      const LoadingDialog(),
      barrierDismissible: false,
    );
    Uri url = Uri.parse(
        'https://$baseUrl/api/v1/auth/password-reset/phone?email=$email&phone_number=$phone&otp=$otp&password=$password&password_confirmation=$confirmPassword');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    // print('Request Password Reset');
    // print(response.statusCode);
    // print(response.body);

    if (response.statusCode == 200) {
      // var jsonResponse = jsonDecode(response.body);

      Navigator.pop(Get.overlayContext!);
      AbySnackBar.successSnackbar(
          text:
              'Password reset successful, you can login with your new password now.');
      Get.offAll(() => const LoginScreen());
      return true;
    } else {
      Navigator.pop(Get.overlayContext!);
      AbySnackBar.errorSnackbar(
          text: 'Request failed with status: ${response.statusCode}.');
      return false;
    }
  }
}
