import 'package:duapa/models/order_detail_class.dart';
import 'package:duapa/models/order_tracking_class.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/order_class.dart';
import '../services/orders_services.dart';
import '../views/widgets/loading_widget.dart';

class OrdersController extends GetxController {
  final OrderServices orderServices = OrderServices();
  // var orders = Rxn<List<OrderModel>?>().obs;
  var paidOrders = Rxn<OrderModel?>().obs;
  var pendingOrders = Rxn<OrderModel?>().obs;
  var completedOrders = Rxn<OrderModel?>().obs;
  var cancelledOrders = Rxn<OrderModel?>().obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    getUserOrders();
    super.onInit();
  }

  Future<void> getOrders() async {
    try {
      Get.dialog(
        const LoadingDialog(),
        barrierDismissible: false,
      );

      final result = await getUserOrders();
      if (result) {
        Navigator.of(Get.overlayContext!).pop();
      } else {
        Navigator.of(Get.overlayContext!).pop();
      }
    } catch (e) {
      Navigator.of(Get.overlayContext!).pop();
    }
  }

  Future<bool> getUserOrders() async {
    final paidResponse = await orderServices.getUserOrders(status: 'Paid');
    final penidngResponse =
        await orderServices.getUserOrders(status: 'Pending');
    final completedResponse =
        await orderServices.getUserOrders(status: 'completed');
    final canceledResponse =
        await orderServices.getUserOrders(status: 'canceled');

    try {
      isLoading(true);
      if (paidResponse != null) {
        paidOrders.value.value = paidResponse;
      }
      if (penidngResponse != null) {
        pendingOrders.value.value = penidngResponse;
      }
      if (completedResponse != null) {
        completedOrders.value.value = completedResponse;
      }
      if (canceledResponse != null) {
        cancelledOrders.value.value = canceledResponse;
      }
      return true;
    } finally {
      isLoading(false);
    }
  }

  var order = Rxn<OrderDetailModel>().obs;
  Future<OrderDetailModel?> getUserOrderDetail(
      {required String orderid}) async {
    isLoading(true);
    final response = await orderServices.getUserOrderDetails(orderid: orderid);

    try {
      if (response != null) {
        order.value.value = response;
        isLoading(false);
        return response;
      } else {
        isLoading(false);
        return null;
      }
    } finally {
      isLoading(false);
    }
  }

  var orderTracking = Rxn<OrderTracking>().obs;
  Future<OrderTracking?> getOrderTracking({required String orderId}) async {
    isLoading(true);
    final response = await orderServices.getOrderTracking(orderId: orderId);

    try {
      if (response != null) {
        orderTracking.value.value = response;
        isLoading(false);
        return response;
      } else {
        isLoading(false);
        return null;
      }
    } finally {
      isLoading(false);
    }
  }
}
