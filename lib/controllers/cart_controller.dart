import 'package:duapa/controllers/product_controller.dart';
import 'package:duapa/services/cart_services.dart';
import 'package:get/get.dart';

import '../models/cart_class.dart';

class CartController extends GetxController {
  final CartServices cartServices = CartServices();
  final ProductsController productsController = Get.find();

  var quantity = <String, int>{}.obs;
  var loading = true.obs;
  RxDouble grandTotal = 0.00.obs;
  RxDouble total = 0.00.obs;
  RxInt cartCount = 0.obs;
  RxDouble totalShipping = 0.00.obs;

  @override
  void onInit() {
    getCartProducts();
    super.onInit();
  }

  Future<bool> addToCart(
      {required String productId, required String quantity}) async {
    var response = await cartServices.addToCart(
      productId: productId,
      quantity: quantity,
    );
    if (response) {
      getCartProducts();
      update();
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteCartProduct({
    required String productId,
    required int index,
  }) async {
    var response = await cartServices.deleteCartProduct(productId: productId);
    if (response) {
      // products.value.value!.removeAt(index);
      getCartProducts();
      productsController.getProducts();
      update();
      return true;
    } else {
      return false;
    }
  }

  var products = Rxn<List<CartProduct>>().obs;
  Future<List<CartProduct>?> getCartProducts() async {
    // if (products.value.value != null) {
    //   products.value.value!.clear();
    //   cartCount(0);
    // }

    final result = await cartServices.getCartProducts();

    if (result != null) {
      grandTotal(0);
      total(0);
      for (var i = 0; i < result.products.length; i++) {
        total.value += result.products[i].totalConvertedPrice;

        totalShipping.value += result.products[i].totalConvertedPrice * 0.10;

        grandTotal.value += result.products[i].totalConvertedPrice +
            (result.products[i].totalConvertedPrice * 0.10);

        quantity.addAll(
          {
            result.products[i].productId:
                int.parse(result.products[i].quantity),
          },
        );
      }
      cartCount(result.totals.totalItems);
      // print(quantity);
      // print(quantity.value['18']);
      products.value(result.products);
      update();
      return products.value.value;
    } else {
      return null;
    }
  }
}
