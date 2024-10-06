import 'package:duapa/services/constants.dart';
import 'package:duapa/services/server.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/user_controller.dart';
import '../views/widgets/loading_widget.dart';

class ProfileServices {
  UserController userController = Get.put(UserController());
  Future<bool> updateProfilePicture({
    required String filepath,
  }) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    Map<String, String> headers = {
      'Content-Type': 'multipart/form-data',
      'Authorization': 'Bearer $token',
    };

    var request = http.MultipartRequest(
        'POST', Uri.https(baseUrl, '/api/v1/auth/users/profile-picture-update'))
      ..headers.addAll(headers)
      ..files.add(await http.MultipartFile.fromPath('picture', filepath));
    var response = await request.send();

    // var res = await response.stream.bytesToString().then((value) => value);
    // print(res);

    if (response.statusCode == 200) {
      AbySnackBar.successSnackbar(
          text: 'Profile picture updated successfully!');
      userController.getUser();
      return true;
    } else {
      AbySnackBar.errorSnackbar(
          text: 'Request failed with status: ${response.statusCode}.');
      return false;
    }
  }

// profile update
  Future<bool> updateProfile({required Map<String, dynamic> body}) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    Get.dialog(
      const LoadingDialog(),
      barrierDismissible: false,
    );
    var response = await http.post(
      Uri.https(baseUrl, '/api/v1/auth/users/profile-update'),
      body: body,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    // print(jsonEncode(body));
    // print(response.body);
    if (response.statusCode == 200) {
      Get.back();
      Get.back();
      AbySnackBar.successSnackbar(text: 'Profile updated successfully!');
      userController.getUser();
      return true;
    } else {
      AbySnackBar.errorSnackbar(
          text: 'Request failed with status: ${response.statusCode}.');
      Navigator.of(Get.overlayContext!).pop();
      return false;
    }
  }

  // password update
  Future<bool> updatePassword(
      {required Map<String, dynamic> body,
      required BuildContext context}) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    Get.dialog(
      const LoadingDialog(),
      barrierDismissible: false,
    );
    var response = await http.post(
      Uri.https(baseUrl, '/api/v1/auth/users/password-update'),
      body: body,
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
    );
    // print(response.body);
    if (response.statusCode == 200) {
      AbySnackBar.successSnackbar(text: 'Password updated successfully!');
      userController.getUser();
      Navigator.of(Get.overlayContext!).pop();
      Navigator.of(Get.overlayContext!).pop();
      return true;
    } else {
      AbySnackBar.errorSnackbar(
          text: 'Request failed with status: ${response.statusCode}.');
      Navigator.of(Get.overlayContext!).pop();
      return false;
    }
  }
}
