import 'package:duapa/controllers/cart_controller.dart';
import 'package:duapa/services/checkout_services.dart';
import 'package:get/get.dart';

import 'orders_controller.dart';

class CheckoutController extends GetxController {
  final CheckoutServices checkoutServices = CheckoutServices();
  final OrdersController ordersController = Get.find();
  final CartController cartController = Get.find();

  RxDouble shipping = 0.10.obs;

  Future<bool> addOrder({
    required String shippingAddress,
    required String deliveryMode,
    required List<Map<String, String>> products,
  }) async {
    var response = await checkoutServices.addOrder(
      shippingAddress: shippingAddress,
      products: products,
      deliveryMode: deliveryMode,
    );

    if (response) {
      ordersController.getOrders();
      cartController.getCartProducts();
    }
    return response;
  }
}
