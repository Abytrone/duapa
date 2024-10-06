import 'dart:convert';

import 'package:duapa/services/constants.dart';
import 'package:duapa/services/server.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/cart_class.dart';

class CartServices {
  Future<bool> addToCart(
      {required String productId, required String quantity}) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');

    // Get.dialog(
    //   const AbyLoadingDialog(message: 'Adding product to cart, please wait...'),
    //   barrierDismissible: false,
    // );
    try {
      var response = await http.post(
        Uri.parse('https://$baseUrl/api/v1/cart/create'),
        body: {
          "product_id": productId,
          "quantity": quantity,
        },
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        // Get.back();
        AbySnackBar.successSnackbar(text: 'Product has been added to cart');
        return true;
      } else {
        // Get.back();
        AbySnackBar.errorSnackbar(text: 'Error adding product to cart');
        return false;
      }
    } catch (e) {
      // Get.back();
      AbySnackBar.errorSnackbar(text: 'Request failed');
      return false;
    }
  }

  Future<bool> updateCart(
      {required String productId, required String quantity}) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    try {
      var response = await http.post(
        Uri.parse('https://$baseUrl/api/v1/cart/create'),
        body: {
          "product_id": productId,
          "quantity": quantity,
        },
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      // print(response.statusCode);
      if (response.statusCode == 200) {
        AbySnackBar.successSnackbar(text: 'Cart updated successfully');
        return true;
      } else {
        AbySnackBar.errorSnackbar(text: 'Error occured while updating cart');
        return false;
      }
    } catch (e) {
      AbySnackBar.errorSnackbar(text: 'Request failed');
      return false;
    }
  }

  //--------------------------------GET-CART-PRODUCTS-----------------------------
  Future<Cart?> getCartProducts() async {
    // Getting user token
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    try {
      var response = await http.get(
        Uri.parse('https://$baseUrl/api/v1/cart/list'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );
      // print(response.body);
      var body = jsonDecode(response.body);
      if (response.statusCode == 200) {
        if (body["products"] != null) {
          var cartProducts = cartFromJson(response.body);

          return cartProducts;
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

  //--------------------------------DELETE-CART-PRODUCTS-----------------------------
  Future<bool> deleteCartProduct({required String productId}) async {
    // Getting user token
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    try {
      var response = await http.get(
        Uri.parse('https://$baseUrl/api/v1/cart/delete/$productId'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );
      // var body = jsonDecode(response.body);
      if (response.statusCode == 200) {
        // trigger cart controller
        AbySnackBar.successSnackbar(text: 'Product deleted from cart!');
        return true;
      } else {
        AbySnackBar.errorSnackbar(
            text: 'Request failed with status: ${response.statusCode}.');
        return false;
      }
    } catch (e) {
      AbySnackBar.errorSnackbar(text: 'Request failed');
      return false;
    }
  }
}
