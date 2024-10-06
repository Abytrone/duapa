import 'dart:convert';

import 'package:duapa/models/unit_of_mearsure_class.dart';
import 'package:duapa/services/auth_services.dart';
import 'package:duapa/services/constants.dart';
import 'package:duapa/services/server.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/category_class.dart';
import '../models/product_details_class.dart';
import '../models/products_model.dart';
import '../models/user_class.dart';
import '../views/widgets/bottom_navy.dart';
import '../views/widgets/loading_widget.dart';

class ProductServices {
  final AuthServices authServices = AuthServices();
  Future<void> uploadProducts(
      {required List<String> imagePaths,
      required Map<String, String> parameters}) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');

    Get.dialog(
      const LoadingDialog(),
      barrierDismissible: false,
    );

    var uri = Uri.parse('https://$baseUrl/api/v1/product/create');
    var request = http.MultipartRequest('POST', uri);

    for (var imagePath in imagePaths) {
      var multipartFile =
          await http.MultipartFile.fromPath('images[]', imagePath);
      request.files.add(multipartFile);
    }

    parameters.forEach((key, value) {
      request.fields[key] = value;
    });

    Map<String, String> headers = {
      'Content-Type': 'multipart/form-data',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    // request.fields.addAll(parameters);
    request.headers.addAll(headers);

    try {
      var response = await request.send();
      // var res = await response.stream.bytesToString().then((value) => value);
      // print(res);
      if (response.statusCode == 201) {
        Navigator.of(Get.overlayContext!).pop();
        AbySnackBar.successSnackbar(text: 'Product added successfully!');
        Get.offAll(() => const BottomNavy(page: 2));
      } else if (response.statusCode == 429) {
        var res = await response.stream.bytesToString().then((value) => value);
        Navigator.of(Get.overlayContext!).pop();
        AbySnackBar.warningSnackbar(text: jsonDecode(res)['message']);
      } else {
        Navigator.of(Get.overlayContext!).pop();
        AbySnackBar.errorSnackbar(
            text: 'Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      Navigator.of(Get.overlayContext!).pop();
      AbySnackBar.errorSnackbar(text: 'Request failed with status: $e.');
    }
  }

  Future<Products> getFarmerProducts() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    Uri url = Uri.parse('https://$baseUrl/api/v1/product/auth/user');
    final response = await http.get(
      url,
      headers: {
        'Accept': '*/*',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    // print(response.body);
    return productsFromJson(response.body);
  }

  // --------------------GET-PRODUCTS---------------------------------------
  static Future<Products> fetchStoreProductsByUserID(
      {required String id}) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    var response = await http.get(
      Uri.https(baseUrl, '/api/v1/product/user/$id'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    var productsList = productsFromJson(response.body);
    // print(response.body);
    return productsList;
  }

  // --------------------GET-PRODUCTS---------------------------------------
  Future<Products?> fetchProducts() async {
    final SharedPreferences localStorage =
        await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    try {
      var response = await http.get(
        Uri.https(baseUrl, productsRoute),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );
      // print(response.body);
      // print(response.statusCode);
      if (response.statusCode == 200) {
        var productsList = productsFromJson(response.body);
        return productsList;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<User?> getUserById({required String id}) async {
    try {
      final SharedPreferences localStorage =
          await SharedPreferences.getInstance();
      var token = localStorage.getString('token');

      Uri url = Uri.parse('https://$baseUrl/api/v1/user/get-user/$id');
      final response = await http.get(
        url,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      // print(id);
      // print('STSTUS CODE: ${response.statusCode}');
      // print(response.body);
      if (response.statusCode == 200) {
        return userFromJson(response.body);
      } else {
        // AbySnackBar.successSnackbar(
        //     text: 'You have been successfully logged out!');
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  // --------------------GET-PRODUCT-DETAILS--------------------------------
  static Future<ProductDetails?> getProductDetails({required String id}) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    var response = await http.get(
      Uri.https(baseUrl, '/api/v1/product/show/$id'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    // print(response.body);
    var productDetails = productDetailsFromJson(response.body);
    return productDetails;
  }

  // --------------------GET-PRODUCTS-BY-CATEGORIES-------------------------------------
  Future<Products?> getProductByCategory({required String categoryID}) async {
    try {
      // Getting user token
      final SharedPreferences localStorage =
          await SharedPreferences.getInstance();
      var token = localStorage.getString('token');

      // final result = await InternetAddress.lookup(baseUrl);
      // if (result.isNotEmpty && result[0].address.isNotEmpty) {
      var response = await http.get(
        Uri.https(baseUrl, '$productByCat/$categoryID'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );
      if (response.statusCode == 200) {
        var productsList = productsFromJson(response.body);
        return productsList;
      } else {
        return null;
      }
      // } else {
      //   print('Address couldn\'t be looked at');
      //   return null;
      // }
    } catch (_) {
      // print(_);
      return null;
    }
  }

  // -----------------------GET-CATEGORIES------------------------------------
  Future<List<Category>?> fetchCategories() async {
    // try {
    // Getting user token
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');

    // final result = await InternetAddress.lookup(baseUrl);
    // if (result.isNotEmpty && result[0].address.isNotEmpty) {
    var response = await http.get(
      Uri.https(baseUrl, catRoute),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );

    if (response.statusCode == 200) {
      List<Category>? categoryList = [];
      var categories = categoryFromJson(response.body);
      for (var i in categories) {
        Category category = Category(
          id: i.id,
          categoryName: i.categoryName,
          picture: i.picture,
          categoryStatus: i.categoryStatus,
          createdAt: i.createdAt,
          updatedAt: i.updatedAt,
        );
        categoryList.add(category);
      }
      return categoryList;
    } else {
      // print('Couldn\'t get posts! ${response.statusCode}');
      return null;
    }
    // } else {
    //   return null;
    // }
  }

  // --------------------GET-UNIT-OF-MEARSURE-------------------------------
  static Future<List<UnitofMearsure>?> getUnits() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    var response = await http.get(
      Uri.https(baseUrl, '/api/v1/product/uom'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    var units = unitofMearsureFromJson(response.body);
    return units;
  }
}
