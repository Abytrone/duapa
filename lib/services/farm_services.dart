import 'package:duapa/services/constants.dart';
import 'package:duapa/services/server.dart';
import 'package:duapa/views/account/farm/farms.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/farms_class.dart';
import '../views/widgets/loading_widget.dart';

class FarmServices {
  //---------------------ADD-Farm---------------------------------
  static Future<bool> addFarm(
      {required Map<String, String> body, required String farmImage}) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    Map<String, String> headers = {
      'Content-Type': 'multipart/form-data',
      'Authorization': 'Bearer $token',
    };
    Get.dialog(
      const LoadingDialog(),
      barrierDismissible: false,
    );
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('https://$baseUrl/api/v1/farmer/farm/add'),
      )
        ..fields.addAll(body)
        ..headers.addAll(headers)
        ..files
            .add(await http.MultipartFile.fromPath('farm_picture', farmImage));
      var response = await request.send();

      var res = await http.Response.fromStream(response);
      print(res.body);

      if (response.statusCode == 200) {
        Navigator.of(Get.overlayContext!).pop();
        AbySnackBar.successSnackbar(text: 'Farm added successfully!');
        Get.to(() => const FarmsScreen());
        return true;
      } else {
        Navigator.of(Get.overlayContext!).pop();
        AbySnackBar.errorSnackbar(
            text: 'Request failed with status: ${response.statusCode}.');
        return false;
      }
    } catch (e) {
      Navigator.of(Get.overlayContext!).pop();
      AbySnackBar.errorSnackbar(text: 'Request failed');
      return false;
    }
  }

  //--------------------------------GET-FARMS-----------------------------
  static Future<List<Farms>?> getFarms() async {
    // Getting user token
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    try {
      var response = await http.get(
        Uri.parse('https://$baseUrl$farmsRoute'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );
      // print(response.body);
      if (response.statusCode == 200) {
        var farmsList = farmsFromJson(response.body);
        return farmsList;
      } else {
        AbySnackBar.errorSnackbar(
            text: 'Request failed with status: ${response.statusCode}.');
        return null;
      }
    } catch (e) {
      AbySnackBar.errorSnackbar(text: 'Request failed');
      return null;
    }
  }
}
