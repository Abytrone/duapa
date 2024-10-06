import 'package:duapa/controllers/checkout_controller.dart';
import 'package:duapa/controllers/controller.dart';
import 'package:duapa/controllers/country_controller.dart';
import 'package:duapa/controllers/extension_service_controller.dart';
import 'package:duapa/controllers/location_controller.dart';
import 'package:duapa/controllers/orders_controller.dart';
import 'package:duapa/controllers/shipping_address_controller.dart';
import 'package:duapa/controllers/user_controller.dart';
import 'package:get/get.dart';

import '../controllers/cart_controller.dart';
import '../controllers/payment_controller.dart';
import '../controllers/product_controller.dart';

class ControllerBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<Controller>(Controller());
    Get.put<UserController>(UserController());
    Get.put<ShippingAddressController>(ShippingAddressController());
    Get.put<OrdersController>(OrdersController());
    Get.put(ProductsController());
    Get.put(CartController());
    Get.put(CheckoutController());
    Get.put(PaymentController());
    Get.put(LocationController());
    Get.put(CountryController());
    Get.put(ExtensionServiceController());
    // Get.put(SettingsController());
  }
}
