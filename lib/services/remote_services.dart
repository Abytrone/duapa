import 'package:duapa/models/coporations_class.dart';
import 'package:duapa/models/transport_class.dart';
import 'package:duapa/services/constants.dart';
import 'package:duapa/services/server.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/ads_class.dart';

class RemoteServices {
  static var client = http.Client();

  //--------------------------------GET-TRANSPORT-----------------------------
  Future<Transport?> getTransport() async {
    // Getting user token
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    try {
      // final result = await InternetAddress.lookup(baseUrl);
      // if (result.isNotEmpty && result[0].address.isNotEmpty) {
      var response = await client.get(
        Uri.https(baseUrl, driversRoute),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );
      if (response.statusCode == 200) {
        var transList = transportFromJson(response.body);
        return transList;
      } else {
        AbySnackBar.errorSnackbar(
            text: 'Request failed with status: ${response.statusCode}.');
        return null;
      }
      // } else {
      //   // Navigator.pop(context);
      //   return null;
      // }
    } catch (e) {
      AbySnackBar.errorSnackbar(text: 'Request failed');
      // Navigator.pop(context);
      return null;
    }
  }

  //--------------------------------GET-GROUPS-----------------------------
  Future<Coporates?> getGroups() async {
    // Getting user token
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    try {
      // final result = await InternetAddress.lookup(baseUrl);
      // if (result.isNotEmpty && result[0].address.isNotEmpty) {
      var response = await client.get(
        Uri.https(baseUrl, coporateGroupsRoute),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );
      if (response.statusCode == 200) {
        var coporatesList = coporatesFromJson(response.body);
        return coporatesList;
      } else {
        AbySnackBar.errorSnackbar(
            text: 'Request failed with status: ${response.statusCode}.');
        // Navigator.pop(context);
        return null;
      }
      // } else {
      //   // Navigator.pop(context);
      //   return null;
      // }
    } catch (e) {
      AbySnackBar.errorSnackbar(text: 'Request failed');
      // Navigator.pop(context);
      return null;
    }
  }

  //--------------------------------ADD-GROUPS-----------------------------
  Future<void> addGroup(Map<String, dynamic> body) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    try {
      var response = await client.post(
        Uri.https(baseUrl, createcoporateGroupRoute),
        body: body,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );
      if (response.statusCode == 201) {
        AbySnackBar.successSnackbar(text: 'Group created successfully.');
      } else {
        AbySnackBar.errorSnackbar(
            text: 'Request failed with status: ${response.statusCode}.');
        return;
      }
    } catch (e) {
      AbySnackBar.errorSnackbar(text: 'Error occured. Try again later.');
      return;
    }
  }

  //--------------------------------JOIN-GROUPS-----------------------------
  Future<void> joinGroup(String id, String groupName) async {
    // Getting user token
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    try {
      var response = await client.get(
        Uri.https(baseUrl, '$joincoporateGroupRoute/$id'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );
      if (response.statusCode == 200) {
        AbySnackBar.successSnackbar(
            text: 'You have joined $groupName successfully.');
      } else {
        AbySnackBar.errorSnackbar(
            text: 'Request failed with status: ${response.statusCode}.');
        return;
      }
    } catch (e) {
      return;
    }
  }

  //--------------------------------GET-ADS-----------------------------
  static Future<Ads?> getAds() async {
    try {
      // Getting user token
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      var token = localStorage.getString('token');
      var response = await client.get(
        Uri.https(baseUrl, adsRoute),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );
      if (response.statusCode == 200) {
        var ads = adsFromJson(response.body);
        return ads;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
