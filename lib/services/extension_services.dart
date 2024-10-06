import 'package:duapa/models/officer_query_class.dart';
import 'package:duapa/models/user_queries_class.dart';
import 'package:duapa/services/server.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/extension_officer_class.dart';
import '../views/widgets/loading_widget.dart';
import 'constants.dart';

class ExtensionServices {
  //--------------------------------GET-GOVERNMENT-OFFICERS-----------------------------
  Future<ExtensionOfficers?> getOfficers() async {
    // Getting user token
    final SharedPreferences localStorage =
        await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    try {
      var response = await http.get(
        Uri.https(baseUrl, governmentRoute),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );
      if (response.statusCode == 200) {
        var officersList = extensionOfficersFromJson(response.body);
        return officersList;
      } else {
        // AbySnackBar.errorSnackbar(
        //     text: 'Request failed with status: ${response.statusCode}.');
        return null;
      }
    } catch (e) {
      AbySnackBar.errorSnackbar(text: 'Request failed');
      return null;
    }
  }

  Future<bool> sendServiceQuery({
    required String title,
    required String description,
    required String officerID,
  }) async {
    Get.dialog(
      const LoadingDialog(),
      barrierDismissible: false,
    );

    final SharedPreferences localStorage =
        await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    try {
      var response = await http.post(
        Uri.parse('https://$baseUrl/api/v1/extension-service/create'),
        body: {
          'title': title,
          'description': description,
          'extension_officer_id': officerID,
        },
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );
      // print(response.body);
      if (response.statusCode == 201) {
        Navigator.of(Get.overlayContext!).pop();
        AbySnackBar.successSnackbar(
            text: 'Your query has been submitted successfully.');
        return true;
      } else {
        Navigator.of(Get.overlayContext!).pop();
        AbySnackBar.warningSnackbar(
            text: 'Couldn\'t submit request, please try again!');
        return false;
      }
    } catch (e) {
      Navigator.of(Get.overlayContext!).pop();
      AbySnackBar.errorSnackbar(
          text: 'Request failed, please try again later!');
      return false;
    }
  }

  Future<bool> sendQueryReply({
    required String id,
    required String content,
  }) async {
    Get.dialog(
      const LoadingDialog(),
      barrierDismissible: false,
    );
    final SharedPreferences localStorage =
        await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    try {
      var response = await http.post(
        Uri.parse('https://$baseUrl/api/v1/extension-service/reply'),
        body: {
          'service_id': id,
          'response': content,
        },
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );
      // print(response.statusCode);
      if (response.statusCode == 200) {
        Navigator.of(Get.overlayContext!).pop();
        Get.back();
        AbySnackBar.successSnackbar(text: 'Query replied successfully.');
        return true;
      } else {
        Navigator.of(Get.overlayContext!).pop();
        AbySnackBar.warningSnackbar(
            text: 'Couldn\'t submit request, please try again!');
        return false;
      }
    } catch (e) {
      // print(e);
      Navigator.of(Get.overlayContext!).pop();
      AbySnackBar.errorSnackbar(
          text: 'Request failed, please try again later!');
      return false;
    }
  }

  //--------------------------------GET-USER-QUERIES-----------------------------
  Future<UserQueriesClass?> getUserQueries() async {
    // Getting user token
    final SharedPreferences localStorage =
        await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    try {
      var response = await http.get(
        Uri.parse('https://$baseUrl/api/v1/extension-service/user-requests'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );
      if (response.statusCode == 200) {
        var queryList = userQueriesClassFromJson(response.body);
        return queryList;
      } else {
        // AbySnackBar.warningSnackbar(
        //     text: 'Request failed with status: ${response.statusCode}.');
        return null;
      }
    } catch (e) {
      AbySnackBar.errorSnackbar(text: 'Request failed $e');
      return null;
    }
  }

  //--------------------------------GET-OFFICER-QUERIES-----------------------------
  Future<OfficerQueryClass?> getOfficerQueries() async {
    // Getting user token
    final SharedPreferences localStorage =
        await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    try {
      var response = await http.get(
        Uri.parse('https://$baseUrl/api/v1/extension-service/officer-requests'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );
      // print(response.body);
      if (response.statusCode == 200) {
        var queryList = officerQueryClassFromJson(response.body);
        return queryList;
      } else {
        // AbySnackBar.warningSnackbar(
        //     text: 'Request failed with status: ${response.statusCode}.');
        return null;
      }
    } catch (e) {
      AbySnackBar.errorSnackbar(text: 'Request failed $e');
      return null;
    }
  }
}
