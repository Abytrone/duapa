import 'dart:convert';

import 'package:duapa/models/shipping_address_class.dart';
import 'package:duapa/services/constants.dart';
import 'package:duapa/services/server.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../views/widgets/loading_widget.dart';

class ShippingAddressServices {
  Future<bool> addAddress({
    required String userid,
    required String email,
    required String phone,
    required String address,
    required String city,
    required String region,
    required String country,
  }) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    Get.dialog(
      const LoadingDialog(),
      barrierDismissible: false,
    );
    try {
      var response = await http.post(
        Uri.parse('https://$baseUrl/api/v1/order/shipping-address/create'),
        body: {
          "email": email,
          "phone": phone,
          "address": address,
          "city": city,
          "region": region,
          "country": country,
        },
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      // print(response.statusCode);
      // print(response.body);
      if (response.statusCode == 201) {
        Navigator.of(Get.overlayContext!).pop();
        AbySnackBar.successSnackbar(text: 'Address added successfully');
        return true;
      } else {
        Navigator.of(Get.overlayContext!).pop();
        AbySnackBar.warningSnackbar(
            text: 'Address could not be added, please try again later!');
        return false;
      }
    } catch (e) {
      Navigator.of(Get.overlayContext!).pop();
      AbySnackBar.errorSnackbar(text: 'Error adding address');
      return false;
    }
  }

  Future<bool> updateAddress({
    required String addressId,
    required String email,
    required String phone,
    required String address,
    required String city,
    required String region,
    required String country,
  }) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    try {
      var response = await http.post(
        Uri.parse('https://$baseUrl/api/v1/order/shipping-address/update'),
        body: {
          "address_id": addressId,
          "email": email,
          "phone": phone,
          "address": address,
          "city": city,
          "region": region,
          "country": country,
        },
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      // print(response.statusCode);
      // print(response.body);
      if (response.statusCode == 200) {
        AbySnackBar.successSnackbar(text: 'Address updated successfully');
        return true;
      } else {
        AbySnackBar.errorSnackbar(text: 'Error updating address');
        return false;
      }
    } catch (e) {
      AbySnackBar.errorSnackbar(text: 'Request failed');
      return false;
    }
  }

  Future<List<ShippingAddressModel>?> getUserAddresses(
      {required String userid}) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    try {
      var response = await http.get(
        Uri.parse('https://$baseUrl/api/v1/order/shipping-address/user-get'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        return shippingAddressModelFromJson(response.body);
      } else {
        AbySnackBar.warningSnackbar(
            text: 'Could not get user addresses, please try again later!');
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<ShippingAddressModel?> getUserDefaultAddresses() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    try {
      var response = await http.get(
        Uri.parse(
            'https://$baseUrl/api/v1/order/shipping-address/user-default-get'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      var body = jsonDecode(response.body);
      // print(response.body);
      if (response.statusCode == 200) {
        if (body["message"] == "No Default Address set") {
          return null;
        } else {
          return ShippingAddressModel.fromJson(jsonDecode(response.body));
        }
      } else {
        // print('Error getting addresses');
        // AbySnackBar.errorSnackbar(text: 'Error getting addresses');
        return null;
      }
    } catch (e) {
      // print(e);
      // AbySnackBar.errorSnackbar(text: 'Request failed');
      return null;
    }
  }

  Future<bool> makeAddressDefault({required String id}) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');

    try {
      var response = await http.get(
        Uri.parse(
            'https://$baseUrl/api/v1/order/shipping-address/make-default/$id'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      // print(response.body);
      if (response.statusCode == 200) {
        AbySnackBar.successSnackbar(text: 'Address made default');
        return true;
      } else {
        AbySnackBar.errorSnackbar(text: 'Error making addresses default');
        return false;
      }
    } catch (e) {
      AbySnackBar.errorSnackbar(text: 'Request failed');
      return false;
    }
  }

  Future<bool> deleteAddress({required String id}) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');

    try {
      var response = await http.get(
        Uri.parse('https://$baseUrl/api/v1/order/shipping-address/delete/$id'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      // print(response.statusCode);
      // print(response.body);
      if (response.statusCode == 200) {
        AbySnackBar.successSnackbar(text: 'Address deleted successfully');
        return true;
      } else {
        AbySnackBar.errorSnackbar(text: 'Error deleting addresses');
        return false;
      }
    } catch (e) {
      AbySnackBar.errorSnackbar(text: 'Request failed');
      return false;
    }
  }
}
