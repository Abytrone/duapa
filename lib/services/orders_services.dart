import 'package:duapa/models/order_tracking_class.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/order_class.dart';
import '../models/order_detail_class.dart';
import 'constants.dart';
import 'server.dart';

class OrderServices {
  Future<OrderModel?> getUserOrders({required String status}) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    try {
      var response = await http.get(
        Uri.parse('$protocol$baseUrl/api/v1/order/get-user-orders/$status'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        return orderModelFromJson(response.body);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<OrderDetailModel?> getUserOrderDetails(
      {required String orderid}) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    try {
      var response = await http.get(
        Uri.parse('$protocol$baseUrl/api/v1/order/get/$orderid'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      // print(response.body);
      if (response.statusCode == 200) {
        return orderDetailModelFromJson(response.body);
      } else {
        AbySnackBar.errorSnackbar(text: 'Error getting orders');
        return null;
      }
    } catch (e) {
      AbySnackBar.errorSnackbar(text: 'Request failed');
      return null;
    }
  }

  Future<OrderTracking?> getOrderTracking({required String orderId}) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    try {
      var response = await http.get(
        Uri.parse('$protocol$baseUrl/api/v1/order-trackings/status/$orderId'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      // print(response.body);
      if (response.statusCode == 200) {
        return orderTrackingFromJson(response.body);
      } else {
        AbySnackBar.errorSnackbar(text: 'Error getting orders');
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
